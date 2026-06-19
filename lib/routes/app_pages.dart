import 'package:get/get.dart';
import '../modules/flight/bindings/flight_binding.dart';
import '../modules/flight/views/plan_trip_screen.dart';
import '../modules/flight/views/flight_result_screen.dart';
import '../modules/flight/views/flight_details_screen.dart';

class Routes {
  static const planTrip = '/plan-trip';
  static const flightResults = '/flight-results';
  static const flightDetails = '/flight-details';
}

class AppPages {
  static final pages = [
    GetPage(name: Routes.planTrip, page: () => const PlanTripScreen(), binding: FlightBinding()),
    GetPage(name: Routes.flightResults, page: () => const FlightResultScreen()),
    GetPage(name: Routes.flightDetails, page: () => const FlightDetailsScreen()),
  ];
}
