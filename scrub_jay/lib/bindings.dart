import 'package:get/get.dart';
import 'package:scrub_jay/controller/driver_controller.dart';
import 'package:scrub_jay/controller/passenger_controller.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PassengerControllerImp());
    Get.lazyPut(() => DriverControllerImp());
  }
}