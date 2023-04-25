import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrub_jay/core/firebase_app_auth.dart';
import 'package:scrub_jay/model/driver.dart';
import 'package:scrub_jay/model/passenger.dart';
import 'package:scrub_jay/view/common_screens/SignUpPassenger.dart';

abstract class SignUpController extends GetxController
    with GetSingleTickerProviderStateMixin {
  Future<void> signup();
}

class SignUpControllerImp extends SignUpController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController fullname = TextEditingController();
  final TextEditingController emailAddress = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController rewritePassword = TextEditingController();

  @override
  signup() async {
    final bool isValid = formKey.currentState!.validate();

    if (isValid) {
      Passenger newPassenger = Passenger(
          fullname: fullname.text.trim(),
          phoneNumber: phoneNumber.text.trim(),
          role: 2);
      final String? uid = await FirebaseAuthApp.firebaseAuthApp
          .signup(2, newPassenger.toJson(), password.text);

      print(uid);
    }
  }
}
