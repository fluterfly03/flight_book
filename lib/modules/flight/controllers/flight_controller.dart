import 'package:get/get.dart';
import '../models/flight_model.dart';
import '../../../routes/app_pages.dart';

class FlightController extends GetxController {
  final from = 'Jakarta (CGK)'.obs;
  final to = 'Tokyo (NRT)'.obs;
  final people = 3.obs;

  final flights = <FlightModel>[
    FlightModel(
      airline: 'Citilink',
      from: 'Jakarta',
      to: 'Tokyo',
      duration: '7h 15m',
      price: 321,
      departureTime: '07:47',
      arrivalTime: '14:30',
      departureAirport: 'CGK',
      arrivalAirport: 'NRT',
      departureDate: 'Jan 20, 2025',
      arrivalDate: 'Jan 20, 2025',
    ),
    FlightModel(
      airline: 'Catty Airline',
      from: 'Jakarta',
      to: 'Tokyo',
      duration: '7h 20m',
      price: 321,
      departureTime: '08:15',
      arrivalTime: '15:10',
      departureAirport: 'CGK',
      arrivalAirport: 'NRT',
      departureDate: 'Jan 20, 2025',
      arrivalDate: 'Jan 20, 2025',
    ),
  ].obs;

  final selectedFlight = Rxn<FlightModel>();

  void swapLocations() {
    final temp = from.value;
    from.value = to.value;
    to.value = temp;
  }

  void searchFlights() {
    Get.toNamed(Routes.flightResults);
  }

  void selectFlight(FlightModel flight) {
    selectedFlight.value = flight;
    Get.toNamed(Routes.flightDetails);
  }
}
