import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrub_jay/core/firebase_app_auth.dart';
import 'package:scrub_jay/model/driver.dart';
import 'package:scrub_jay/model/passenger.dart';
import 'package:scrub_jay/view/common_screens/SignUpPassenger.dart';

abstract class DriverController extends GetxController
    with GetSingleTickerProviderStateMixin {
  Future<void> driverSignup();
}

class DriverControllerImp extends DriverController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController fullname = TextEditingController();
  final TextEditingController emailAddress = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController rewritePassword = TextEditingController();

  @override
  driverSignup() async {
    final bool isValid = formKey.currentState!.validate();

    if (isValid) {
      Driver newDriver = Driver(
          fullname: fullname.text.trim(),
          phoneNumber: phoneNumber.text.trim(),
          role: 1);
      final String? uid = await FirebaseAuthApp.firebaseAuthApp
          .signup(1, newDriver.toJson(), password.text);

      print(uid);
    }
  }
}
