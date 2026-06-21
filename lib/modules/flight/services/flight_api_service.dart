import 'dart:convert';

import '../models/airline_model.dart';
import '../models/airport_model.dart';
import '../models/flight_model.dart';
import '../models/flight_details_model.dart';
import '../models/aircraft_type_model.dart';
import 'api_client.dart';

class FlightApiService {
  static const String _searchPath = '/flight_api.php/search';
  static const String _flightPath = '/flight_api.php/flight';
  static const String _aircraftTypesPath = '/flight_api.php/aircraft-types';
  static const String _airlinesPath = '/flight_api.php/airlines';
  static const String _airportsFromPath = '/flight_api.php/airports/from';
  static const String _airportsToPath = '/flight_api.php/airports/to';

  /// Search flights using centralized ApiClient
  static Future<List<FlightModel>> searchFlights({
    required String from,
    required String to,
    required int passengers,
    String sortBy = 'price_asc',
    Map<String, dynamic>? filters,
  }) async {
    final body = {
      'from': from,
      'to': to,
      'passengers': passengers,
      'sort_by': sortBy,
      'filters': filters ?? {
        'airline': '',
        'price_min': 0,
        'price_max': 0,
        'stops': 0,
        'aircraft_type': ''
      }
    };

    final client = ApiClient.instance;
    // ApiClient should be initialized in main.dart once. Just call post here.
    try {
      final response = await client.post(_searchPath, data: body);

      if (response.statusCode == 200 || response.statusCode == 202) {
        final Map<String, dynamic> data = response.data is String ? jsonDecode(response.data) : response.data as Map<String, dynamic>;
        if (data['status'] == 'success' && data['data'] != null) {
          final flightsJson = data['data']['flights'] as List<dynamic>?;
          if (flightsJson == null) return [];
          return flightsJson.map((e) => FlightModel.fromJson(e as Map<String, dynamic>)).toList();
        } else if (response.statusCode == 202) {
          // queued
          return [];
        } else {
          throw ApiException(data['message'] ?? 'Unknown API error', statusCode: response.statusCode);
        }
      } else {
        throw ApiException('Network error: ${response.statusCode}', statusCode: response.statusCode);
      }
    } on ApiException {
      rethrow;
    } catch (e) {
      // Wrap unexpected errors
      throw ApiException(e.toString());
    }
  }

  /// Fetch flight details by ID
  static Future<FlightDetailsResponse> fetchFlightDetails({
    required int flightId,
  }) async {
    final body = {
      'id': flightId,
    };

    final client = ApiClient.instance;
    try {
      final response = await client.post(_flightPath, data: body);

      if (response.statusCode == 200 || response.statusCode == 202) {
        final Map<String, dynamic> data = response.data is String
            ? jsonDecode(response.data)
            : response.data as Map<String, dynamic>;
        if (data['status'] == 'success') {
          return FlightDetailsResponse.fromJson(data);
        } else if (response.statusCode == 202) {
          // queued
          throw ApiException('Request queued due to offline mode',
              statusCode: response.statusCode);
        } else {
          throw ApiException(data['message'] ?? 'Unknown API error',
              statusCode: response.statusCode);
        }
      } else {
        throw ApiException('Network error: ${response.statusCode}',
            statusCode: response.statusCode);
      }
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(e.toString());
    }
  }

      /// Fetch aircraft types with pagination and optional search
      static Future<AircraftTypesResponse> fetchAircraftTypes({
        String search = '',
        int limit = 10,
        int page = 1,
      })
      async {
        final body = {
          'search': search,
          'limit': limit,
          'page': page,
        };

        final client = ApiClient.instance;
        try {
          final response = await client.post(_aircraftTypesPath, data: body);

          if (response.statusCode == 200 || response.statusCode == 202) {
            final Map<String, dynamic> data = response.data is String
                ? jsonDecode(response.data)
                : response.data as Map<String, dynamic>;
            if (data['status'] == 'success' && data['data'] != null) {
              return AircraftTypesResponse.fromJson(data);
            } else if (response.statusCode == 202) {
              throw ApiException('Request queued due to offline mode', statusCode: response.statusCode);
            } else {
              throw ApiException(data['message'] ?? 'Unknown API error', statusCode: response.statusCode);
            }
          } else {
            throw ApiException('Network error: ${response.statusCode}', statusCode: response.statusCode);
          }
        } on ApiException {
          rethrow;
        } catch (e) {
          throw ApiException(e.toString());
        }
      }
  /// Fetch airlines with pagination and optional search
  static Future<AirlinesResponse> fetchAirlines({
    String search = '',
    int limit = 10,
    int page = 1,
  }) async {
    final body = {
      'search': search,
      'limit': limit,
      'page': page,
    };

    final client = ApiClient.instance;

    try {
      final response = await client.post(
        _airlinesPath,
        data: body,
      );

      if (response.statusCode == 200 ||
          response.statusCode == 202) {
        final Map<String, dynamic> data =
        response.data is String
            ? jsonDecode(response.data)
            : response.data as Map<String, dynamic>;

        if (data['status'] == 'success' &&
            data['data'] != null) {
          return AirlinesResponse.fromJson(data);
        } else if (response.statusCode == 202) {
          throw ApiException(
            'Request queued due to offline mode',
            statusCode: response.statusCode,
          );
        } else {
          throw ApiException(
            data['message'] ?? 'Unknown API error',
            statusCode: response.statusCode,
          );
        }
      } else {
        throw ApiException(
          'Network error: ${response.statusCode}',
          statusCode: response.statusCode,
        );
      }
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(e.toString());
    }
  }

  /// Fetch airports for departure (from)
  static Future<List<Airport>> fetchAirportsFrom({
    String search = '',
    int limit = 20,
    int page = 1,
  }) async {
    final body = {
      'search': search,
      'limit': limit,
      'page': page,
    };

    final client = ApiClient.instance;
    try {
      final response = await client.post(_airportsFromPath, data: body);
      // Print/debug the raw response for debugging
      ApiClient.instance.debugLog('fetchAirportsFrom response: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 202) {
        final Map<String, dynamic> data = response.data is String
            ? jsonDecode(response.data)
            : response.data as Map<String, dynamic>;
        if (data['status'] == 'success' && data['data'] != null) {
          final airportsJson = data['data']['airports'] as List<dynamic>?;
          if (airportsJson == null) return [];
          return airportsJson
              .map((e) => Airport.fromJson(e as Map<String, dynamic>))
              .toList();
        } else if (response.statusCode == 202) {
          // queued
          return [];
        } else {
          throw ApiException(data['message'] ?? 'Unknown API error',
              statusCode: response.statusCode);
        }
      } else {
        throw ApiException('Network error: ${response.statusCode}',
            statusCode: response.statusCode);
      }
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(e.toString());
    }
  }

  /// Fetch airports for arrival (to)
  static Future<List<Airport>> fetchAirportsTo({
    String search = '',
    int limit = 20,
    int page = 1,
  }) async {
    final body = {
      'search': search,
      'limit': limit,
      'page': page,
    };

    final client = ApiClient.instance;
    try {
      final response = await client.post(_airportsToPath, data: body);
      // Print/debug the raw response for debugging
      ApiClient.instance.debugLog('fetchAirportsTo response: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 202) {
        final Map<String, dynamic> data = response.data is String
            ? jsonDecode(response.data)
            : response.data as Map<String, dynamic>;
        if (data['status'] == 'success' && data['data'] != null) {
          final airportsJson = data['data']['airports'] as List<dynamic>?;
          if (airportsJson == null) return [];
          return airportsJson
              .map((e) => Airport.fromJson(e as Map<String, dynamic>))
              .toList();
        } else if (response.statusCode == 202) {
          // queued
          return [];
        } else {
          throw ApiException(data['message'] ?? 'Unknown API error',
              statusCode: response.statusCode);
        }
      } else {
        throw ApiException('Network error: ${response.statusCode}',
            statusCode: response.statusCode);
      }
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(e.toString());
    }
  }
}


