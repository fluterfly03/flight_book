import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/flight_model.dart';
import '../../../routes/app_pages.dart';
import '../services/api_client.dart';
import '../services/flight_api_service.dart';

class FlightController extends GetxController {
  final from = 'Jakarta (CGK)'.obs;
  final to = 'Tokyo (NRT)'.obs;
  final people = 3.obs;

  // start with empty list; searchFlights will populate via API
  final flights = <FlightModel>[].obs;

  final selectedFlight = Rxn<FlightModel>();
  final isLoading = false.obs;

  void swapLocations() {
    final temp = from.value;
    from.value = to.value;
    to.value = temp;
  }

  void searchFlights() {
    // perform API search then navigate to results
    _searchAndNavigate();
  }

  Future<void> _searchAndNavigate() async {
    try {
      // show loading
      isLoading.value = true;
      Get.dialog(const Center(child: CircularProgressIndicator()), barrierDismissible: false);
      String extractCode(String s) {
        final match = RegExp(r"\(([^)]+)\)").firstMatch(s);
        if (match != null && match.groupCount >= 1) return match.group(1)!;
        // fallback: if value looks like an airport code already
        if (s.trim().length <= 4 && s.trim().toUpperCase() == s.trim()) return s.trim();
        // otherwise return last token
        final parts = s.trim().split(RegExp(r"\s+"));
        return parts.isNotEmpty ? parts.last : s;
      }

      final results = await FlightApiService.searchFlights(
        from: extractCode(from.value),
        to: extractCode(to.value),
        passengers: people.value,
        sortBy: 'price_asc',
      );
      flights.value = results;
      // close loading before navigation
      try { Get.back(); } catch (_) {}
      isLoading.value = false;
      Get.toNamed(Routes.flightResults);
    } catch (e) {
      try { Get.back(); } catch (_) {}
      isLoading.value = false;
      final message = e is ApiException ? e.message : 'Something went wrong. Please try again.';
      Get.snackbar('Error', message, snackPosition: SnackPosition.BOTTOM);
    }
  }

  void selectFlight(FlightModel flight) {
    selectedFlight.value = flight;
    Get.toNamed(Routes.flightDetails);
  }
}
