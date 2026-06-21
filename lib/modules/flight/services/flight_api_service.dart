import 'dart:convert';

import '../models/flight_model.dart';
import 'api_client.dart';

class FlightApiService {
  static const String _searchPath = '/flight_api.php/search';

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
}




