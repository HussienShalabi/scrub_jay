import 'package:get/get.dart';
import 'package:scrub_jay/controller/driver_controller.dart';
import 'package:scrub_jay/controller/passenger_controller.dart';
import 'package:scrub_jay/controller/signin_controller.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PassengerControllerImp(), fenix: true);
    Get.lazyPut(() => DriverControllerImp(), fenix: true);

    Get.lazyPut(() => SignInControllerImp(), fenix: true);
  }
}