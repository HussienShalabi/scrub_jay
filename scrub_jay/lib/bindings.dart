import 'package:get/get.dart';
import 'package:scrub_jay/controller/account_controller.dart';
import 'package:scrub_jay/controller/auth_controller.dart';
import 'package:scrub_jay/controller/driver_controller.dart';

import 'controller/AdminController.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthControllerImp(), fenix: true);
    Get.lazyPut(() => DriverControllerImp(), fenix: true);
    Get.lazyPut(() => AccountManagement(), fenix: true);
    Get.lazyPut(() => DriverControllerImp(), fenix: true);
    Get.lazyPut(() => AdminControllerImp(), fenix: true);
  }
}
