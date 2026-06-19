import 'package:get/get.dart';
import '../controllers/flight_controller.dart';
class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      FlightController(),
      permanent: true,
    );
  }
}