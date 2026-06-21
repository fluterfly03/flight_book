import 'package:flight_book/modules/flight/views/widgets/pasanger_selector.dart';
import 'package:get/get.dart';

class FlightSearchController extends GetxController {
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
}