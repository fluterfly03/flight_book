import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Centralized API client with environment support, interceptors, retry/backoff,
/// caching, auth token management, deduplication and offline queueing.
class ApiClient {
  ApiClient._internal();

  static final ApiClient instance = ApiClient._internal();

  late Dio _dio;
  final Map<String, dynamic> _cache = {}; // simple in-memory cache: key -> {data, expiry}
  final Map<String, Future<Response>> _pendingRequests = {}; // dedupe
  final List<Map<String, dynamic>> _offlineQueue = []; // queued requests when offline

  // configuration
  String baseUrl = 'https://flight.wigian.in';
  Duration requestTimeout = const Duration(seconds: 60);
  bool enableLogging = true;

  // auth
  String? _authToken;

  // connectivity
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult>? _connectivitySub;

  Future<void> init({
    String? baseUrl,
    Duration? timeout,
    bool logging = true,
  }) async {
    if (baseUrl != null) this.baseUrl = baseUrl;
    if (timeout != null) requestTimeout = timeout;
    enableLogging = logging;

    _dio = Dio(BaseOptions(
      baseUrl: this.baseUrl,
      connectTimeout: requestTimeout,
      receiveTimeout: requestTimeout,
      sendTimeout: requestTimeout,
      responseType: ResponseType.json,
    ),);

    // add interceptors
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // Attach auth token if present
        if (_authToken != null && _authToken!.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $_authToken';
        }
        if (enableLogging) {
          debugLog('REQUEST => ${options.method} ${options.uri}');
          debugLog('Headers: ${options.headers}');
          debugLog('Data: ${options.data}');
        }
        handler.next(options);
      },
      onResponse: (response, handler) async {
        if (enableLogging) debugLog('RESPONSE <= ${response.requestOptions.method} ${response.requestOptions.uri} ${response.statusCode}');
        handler.next(response);
      },
      onError: (err, handler) async {
        if (enableLogging) debugLog('ERROR <= ${err.requestOptions.method} ${err.requestOptions.uri} : ${err.message}');
        handler.next(err);
      },
    ));

    // listen connectivity to flush queue
    _connectivitySub?.cancel();
    _connectivitySub = _connectivity.onConnectivityChanged.listen((result) {
      if (result != ConnectivityResult.none) {
        _flushQueue();
      }
    });

    // restore queued requests from preferences
    await _loadQueueFromStorage();
  }

  void dispose() {
    _connectivitySub?.cancel();
  }

  void setAuthToken(String? token) {
    _authToken = token;
  }

  // simple logging helper
  void debugLog(Object? o) {
    if (enableLogging) {
      // ignore: avoid_print
      print('[ApiClient] $o');
    }
  }

  String _requestKey(RequestOptions options) {
    final dataString = options.data != null ? jsonEncode(options.data) : '';
    return '${options.method}:${options.uri.toString()}:$dataString';
  }

  // public wrappers
  Future<Response> get(String path, {Map<String, dynamic>? queryParameters, bool forceRefresh = false, Duration? cacheDuration}) {
    final options = Options(method: 'GET');
    final requestOptions = RequestOptions(path: path, method: 'GET', queryParameters: queryParameters ?? {}, baseUrl: baseUrl, headers: {});
    return _request(requestOptions, options: options, forceRefresh: forceRefresh, cacheDuration: cacheDuration);
  }

  Future<Response> post(String path, {dynamic data, Map<String, dynamic>? queryParameters, bool queueIfOffline = true}) async {
    final options = Options(method: 'POST');
    final requestOptions = RequestOptions(path: path, method: 'POST', data: data, queryParameters: queryParameters ?? {}, baseUrl: baseUrl, headers: {});
    return _request(requestOptions, options: options, queueIfOffline: queueIfOffline);
  }

  Future<Response> _request(RequestOptions requestOptions, {Options? options, bool forceRefresh = false, Duration? cacheDuration, bool queueIfOffline = false}) async {
    final key = _requestKey(requestOptions);

    // deduplication: return pending future if exists
    if (_pendingRequests.containsKey(key)) return _pendingRequests[key]!;

    final future = _performWithRetry(requestOptions, options: options, forceRefresh: forceRefresh, cacheDuration: cacheDuration, queueIfOffline: queueIfOffline);
    _pendingRequests[key] = future;

    try {
      final res = await future;
      return res;
    } finally {
      // remove pending
      _pendingRequests.remove(key);
    }
  }

  Future<Response> _performWithRetry(RequestOptions requestOptions, {Options? options, bool forceRefresh = false, Duration? cacheDuration, bool queueIfOffline = false}) async {
    // check GET cache
    if (requestOptions.method == 'GET' && !forceRefresh) {
      final cacheKey = requestOptions.uri.toString();
      final cached = _cache[cacheKey];
      if (cached != null) {
        final expiry = cached['expiry'] as DateTime;
        if (DateTime.now().isBefore(expiry)) {
          // return a fake Dio Response
          return Response(requestOptions: requestOptions, data: cached['data'], statusCode: 200, statusMessage: 'OK');
        } else {
          _cache.remove(cacheKey);
        }
      }
    }

    // If offline and queue allowed for non-GET requests
    final connectivity = await _connectivity.checkConnectivity();
    if (connectivity == ConnectivityResult.none && queueIfOffline && requestOptions.method != 'GET') {
      // queue request and persist
      _queueRequest(requestOptions);
      // return a synthetic response indicating queued state
      return Response(requestOptions: requestOptions, data: {'status': 'queued', 'message': 'Request queued due to offline'}, statusCode: 202);
    }

    int attempt = 0;
    const int maxAttempts = 4;
    while (true) {
      try {
        final response = await _dio.fetch(requestOptions);

        // store GET cache
        if (requestOptions.method == 'GET' && response.statusCode == 200 && cacheDuration != null) {
          final cacheKey = requestOptions.uri.toString();
          _cache[cacheKey] = {'data': response.data, 'expiry': DateTime.now().add(cacheDuration)};
        }

        return response;
      } catch (e) {
        attempt++;
        // handle Dio-specific exceptions
        if (e is DioException) {
          final resp = e.response;
          final status = resp?.statusCode;

          // client errors (4xx) -> do not retry
          if (status != null && status >= 400 && status < 500) {
            final msg = resp?.data != null && resp?.data is Map ? (resp?.data['message'] ?? 'Client error') : e.message;
            throw ApiException(msg.toString(), statusCode: status);
          }

          // server errors (5xx) or connection issues -> retry up to maxAttempts
          if (attempt >= maxAttempts) {
            // map common DioException types to friendly messages
            final DioExceptionType t = e.type;
            String friendly;
            if (t == DioExceptionType.connectionTimeout || t == DioExceptionType.receiveTimeout || t == DioExceptionType.sendTimeout) {
              friendly = 'Request timed out. Please check your connection and try again.';
            } else if (t == DioExceptionType.connectionError) {
              friendly = 'Network error. Please check your internet connection.';
            } else {
              friendly = resp?.statusMessage ?? e.message ?? 'Unexpected network error';
            }
            throw ApiException(friendly, statusCode: status);
          }

          // otherwise wait and retry
          final delayMs = pow(2, attempt) * 250; // e.g., 500, 1000, 2000, ...
          await Future.delayed(Duration(milliseconds: delayMs.toInt()));
          continue;
        }

        // non-Dio errors: retry until maxAttempts
        if (attempt >= maxAttempts) rethrow;
        final delayMs = pow(2, attempt) * 250;
        await Future.delayed(Duration(milliseconds: delayMs.toInt()));
      }
    }
  }

  void _queueRequest(RequestOptions options) async {
    final item = {
      'method': options.method,
      'path': options.path,
      'data': options.data,
      'queryParameters': options.queryParameters,
      'headers': options.headers,
    };
    _offlineQueue.add(item);
    await _saveQueueToStorage();
  }

  Future<void> _flushQueue() async {
    if (_offlineQueue.isEmpty) return;
    debugLog('Flushing offline queue (${_offlineQueue.length})');
    final queueCopy = List<Map<String, dynamic>>.from(_offlineQueue);
    _offlineQueue.clear();
    await _saveQueueToStorage();

    for (final item in queueCopy) {
      try {
        final method = item['method'] as String;
        final path = item['path'] as String;
        final data = item['data'];
        final query = Map<String, dynamic>.from(item['queryParameters'] ?? {});
        if (method.toUpperCase() == 'POST') {
          await post(path, data: data, queryParameters: query, queueIfOffline: false);
        } else {
          await get(path, queryParameters: query);
        }
      } catch (e) {
        debugLog('Failed queued request: $e');
      }
    }
  }

  Future<void> _saveQueueToStorage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('api_offline_queue', jsonEncode(_offlineQueue));
  }

  Future<void> _loadQueueFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString('api_offline_queue');
    if (raw != null) {
      try {
        final List<dynamic> list = jsonDecode(raw);
        _offlineQueue.clear();
        for (final item in list) {
          _offlineQueue.add(Map<String, dynamic>.from(item as Map));
        }
      } catch (e) {
        debugLog('Failed to restore queue: $e');
      }
    }
  }
}

/// Custom exception for API errors with friendly messages
class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException(this.message, {this.statusCode});

  @override
  String toString() => 'ApiException{statusCode: $statusCode, message: $message}';
}






