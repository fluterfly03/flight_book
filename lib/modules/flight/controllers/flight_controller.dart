import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/airline_model.dart';
import '../models/airport_model.dart';
import '../models/flight_model.dart';
import '../models/flight_details_model.dart';
import '../models/aircraft_type_model.dart';
import '../views/widgets/aircraft_type_selector.dart';
import '../../../routes/app_pages.dart';
import '../services/api_client.dart';
import '../services/flight_api_service.dart';
import '../views/widgets/airlines_selector.dart';
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

  final departureDate = DateTime
      .now()
      .obs;

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
  final selectedFlightDetails = Rxn<FlightDetailsResponse>();
  final isLoading = false.obs;
  // Aircraft types state for selector
  final aircraftTypes = <AircraftType>[].obs;
  final aircraftTypesPage = 1.obs;
  final aircraftTypesHasNext = false.obs;
  final isLoadingAircraftTypes = false.obs;
  final isLoadingMoreAircraftTypes = false.obs;
  final selectedAircraftType = ''.obs;

  // Airlines state for selector
  final airlines = <Airline>[].obs;
  final airlinesPage = 1.obs;
  final airlinesHasNext = false.obs;
  final isLoadingAirlines = false.obs;
  final isLoadingMoreAirlines = false.obs;
  final selectedAirlines = ''.obs;


  void searchFlights() {
    // perform API search then navigate to results
    _searchAndNavigate();
  }

  Future<void> _searchAndNavigate() async {
    try {
      // show loading
      isLoading.value = true;
      Get.dialog(const Center(child: CircularProgressIndicator()),
          barrierDismissible: false);
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
        filters: {
          'aircraft_type': selectedAircraftType.value,
        },
      );
      flights.value = results;
      // close loading before navigation
      try {
        Get.back();
      } catch (_) {}
      isLoading.value = false;
      Get.toNamed(Routes.flightResults);
    } catch (e) {
      try {
        Get.back();
      } catch (_) {}
      isLoading.value = false;
      final message = e is ApiException
          ? e.message
          : 'Something went wrong. Please try again.';
      Get.snackbar('Error', message, snackPosition: SnackPosition.BOTTOM);
    }
  }

  void selectFlight(FlightModel flight) {
    selectedFlight.value = flight;
    _fetchFlightDetails(flight.id ?? 0);
  }

  void openAircraftTypeSelector() {
    Get.bottomSheet(
      const AircraftTypeSelector(),
      isScrollControlled: true,
    );
  }void openAirlinesSelector() {
    Get.bottomSheet(
      const AirlineSelector(),
      isScrollControlled: true,
    );
  }

  /// Fetch aircraft types. When [append] is true, append results to existing list.
  Future<void> fetchAircraftTypes({String search = '', int limit = 10, int page = 1, bool append = false}) async {
    try {
      if (append) {
        isLoadingMoreAircraftTypes.value = true;
      } else {
        isLoadingAircraftTypes.value = true;
      }

      final resp = await FlightApiService.fetchAircraftTypes(search: search, limit: limit, page: page);

      final list = resp.aircraftTypes;
      if (append) {
        aircraftTypes.addAll(list);
      } else {
        aircraftTypes.assignAll(list);
      }

      aircraftTypesPage.value = resp.pagination?.currentPage ?? page;
      aircraftTypesHasNext.value = resp.pagination?.hasNextPage ?? false;
    } catch (e) {
      final message = e is ApiException ? e.message : 'Failed to load aircraft types';
      Get.snackbar('Error', message, snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoadingAircraftTypes.value = false;
      isLoadingMoreAircraftTypes.value = false;
    }
  }
  Future<void> fetchAirlines({
    String search = '',
    int limit = 10,
    int page = 1,
    bool append = false,
  }) async {
    try {
      if (append) {
        isLoadingMoreAirlines.value = true;
      } else {
        isLoadingAirlines.value = true;
      }

      final resp = await FlightApiService.fetchAirlines(
        search: search,
        limit: limit,
        page: page,
      );

      final list = resp.airlines;

      if (append) {
        airlines.addAll(list);
      } else {
        airlines.assignAll(list);
      }

      airlinesPage.value =
          resp.pagination?.currentPage ?? page;

      airlinesHasNext.value =
          resp.pagination?.hasNextPage ?? false;
    } catch (e) {
      final message = e is ApiException
          ? e.message
          : 'Failed to load airlines';

      Get.snackbar(
        'Error',
        message,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoadingAirlines.value = false;
      isLoadingMoreAirlines.value = false;
    }
  }
  Future<void> _fetchFlightDetails(int flightId) async {
    try {
      isLoading.value = true;
      Get.dialog(const Center(child: CircularProgressIndicator()),
          barrierDismissible: false);

      final details = await FlightApiService.fetchFlightDetails(
        flightId: flightId,
      );
      selectedFlightDetails.value = details;

      // close loading before navigation
      try {
        Get.back();
      } catch (_) {}
      isLoading.value = false;
      Get.toNamed(Routes.flightDetails);
    } catch (e) {
      try {
        Get.back();
      } catch (_) {}
      isLoading.value = false;
      final message = e is ApiException
          ? e.message
          : 'Failed to load flight details. Please try again.';
      Get.snackbar('Error', message, snackPosition: SnackPosition.BOTTOM);
    }
  }
}