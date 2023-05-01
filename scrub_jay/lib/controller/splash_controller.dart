import 'dart:async';
import 'package:get/get.dart';

abstract class SplashController extends GetxController {
  Future<void> checkAuth();
}

class SplashControllerImp extends SplashController {
  bool isVisible = false;

  @override
  checkAuth() async {
    // Timer(const Duration(seconds: 2), () {
    //   setState(() {
    //     Navigator.of(context).pushAndRemoveUntil(
    //         MaterialPageRoute(builder: (context) => const Signin()),
    //             (route) => false);
    //   });
    // });

    Timer(const Duration(milliseconds: 1000), () {
      isVisible = true;

      update();
    });

    await Future.delayed(const Duration(seconds: 2));

    Get.offNamed('/Signin');
  }

  @override
  void onInit() {
    super.onInit();
    checkAuth();
  }
}
