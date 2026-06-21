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
