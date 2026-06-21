import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/airport_model.dart';
import '../models/flight_model.dart';
import '../../../routes/app_pages.dart';
import '../services/api_client.dart';
import '../services/flight_api_service.dart';
import '../views/widgets/pasanger_selector.dart';

class FlightController extends GetxController {
  final from = 'Jakarta (CGK)'.obs;
  final to = 'Tokyo (NRT)'.obs;
  final fromAirports = <Airport>[].obs;
  final toAirports = <Airport>[].obs;
  final from1 = Rxn<Airport>();
  final to1 = Rxn<Airport>();
  final passengerCount = 1.obs;

  void incrementPassenger() {
    passengerCount.value++;
  }

  void decrementPassenger() {
    if (passengerCount.value > 1) {
      passengerCount.value--;
    }
  }

  void openPassengerSelector() {
    Get.bottomSheet(
      PasangerSelector(),
    );
  }

  void swapLocations() {
    final temp = from1.value;
    from1.value = to1.value;
    to1.value = temp;
  }
  final departureDate = DateTime.now().obs;

  Future<void> pickDepartureDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: departureDate.value,
      firstDate: DateTime.now(),
      lastDate: DateTime(2035),
    );

    if (picked != null) {
      departureDate.value = picked;
    }
  }
  @override
  void onInit() {
    super.onInit();
    _loadAirports();
  }

  Future<void> _loadAirports() async {
    try {
      // Fetch airports for both from and to
      final fromAirports = await FlightApiService.fetchAirportsFrom(limit: 20);
      final toAirports = await FlightApiService.fetchAirportsTo(limit: 20);

      // Use 'from' airports as the main list (you can adjust this logic as needed)
      this.fromAirports.assignAll(fromAirports);
      this.toAirports.assignAll(toAirports);

      // Set default from and to if available
      if (fromAirports.isNotEmpty && toAirports.isNotEmpty) {
        from1.value = fromAirports.first;
        to1.value = toAirports.first;
      }
    } catch (e) {
      // Log error but don't crash; airports list remains empty
      print('Error loading airports: $e');
    }
  }

  void setFrom(Airport airport) {
    from1.value = airport;
  }

  void setTo(Airport airport) {
    to1.value = airport;
  }
  final people = 3.obs;

  // start with empty list; searchFlights will populate via API
  final flights = <FlightModel>[].obs;

  final selectedFlight = Rxn<FlightModel>();
  final isLoading = false.obs;


  void searchFlights() {
    // perform API search then navigate to results
    _searchAndNavigate();
  }

  Future<void> _searchAndNavigate() async {
    try {
      // show loading
      isLoading.value = true;
      Get.dialog(const Center(child: CircularProgressIndicator()), barrierDismissible: false);
      // helper to get airport code from selected Airport or from fallback string
      String extractCodeFromAirportOrString() {
        // prefer the selected Airport (from1/to1) if set
        String fromCode = '';
        if (from1.value != null) {
          fromCode = from1.value!.airportCode;
        } else if (from.value.isNotEmpty) {
          final match = RegExp(r"\(([^)]+)\)").firstMatch(from.value);
          if (match != null && match.groupCount >= 1) {
            fromCode = match.group(1)!;
          } else {
            final parts = from.value.trim().split(RegExp(r"\s+"));
            fromCode = parts.isNotEmpty ? parts.last : from.value;
          }
        }

        return fromCode;
      }

      String extractCodeToAirportOrString() {
        String toCode = '';
        if (to1.value != null) {
          toCode = to1.value!.airportCode;
        } else if (to.value.isNotEmpty) {
          final match = RegExp(r"\(([^)]+)\)").firstMatch(to.value);
          if (match != null && match.groupCount >= 1) {
            toCode = match.group(1)!;
          } else {
            final parts = to.value.trim().split(RegExp(r"\s+"));
            toCode = parts.isNotEmpty ? parts.last : to.value;
          }
        }
        return toCode;
      }

      final fromCode = extractCodeFromAirportOrString();
      final toCode = extractCodeToAirportOrString();

      final results = await FlightApiService.searchFlights(
        from: fromCode,
        to: toCode,
        passengers: passengerCount.value,
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
