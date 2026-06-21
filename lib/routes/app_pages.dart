import 'package:get/get.dart';
import '../modules/flight/bindings/flight_binding.dart';
import '../modules/flight/views/screens/flight_details_screen.dart';
import '../modules/flight/views/screens/plan_trip_screen.dart';
import '../modules/flight/views/screens/flight_listing_screen.dart';

class Routes {
  static const planTrip = '/plan-trip';
  static const flightResults = '/flight-results';
  static const flightDetails = '/flight-details';
}

class AppPages {
  static final pages = [
    GetPage(name: Routes.planTrip, page: () => const PlanTripScreen(), binding: FlightBinding()),
    GetPage(name: Routes.flightResults, page: () => const FlightListingScreen()),
    GetPage(name: Routes.flightDetails, page: () => const
    FlightDetailsScreen()),
  ];
}
