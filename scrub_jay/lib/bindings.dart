import 'package:get/get.dart';
import 'package:scrub_jay/controller/signup_controller.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignUpControllerImp());
  }
}