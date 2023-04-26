import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrub_jay/core/firebase_app_auth.dart';
import 'package:scrub_jay/model/driver.dart';
import 'package:scrub_jay/model/passenger.dart';
import 'package:scrub_jay/view/Passenger/ChooseTrip.dart';
import 'package:scrub_jay/view/common_screens/SignUpPassenger.dart';

abstract class SignInController extends GetxController {
  Future<void> signIn();
}

class SignInControllerImp extends SignInController {
  bool isLoading = false;


  final GlobalKey<FormState> formKeySignIn = GlobalKey<FormState>();
  final TextEditingController emailAddressSignin = TextEditingController();
  final TextEditingController passwordSignin = TextEditingController();

  @override
  signIn() async {
    final bool isValid = formKeySignIn.currentState!.validate();
    isLoading = true;
    update();

    if (isValid) {
      final String? uid = await FirebaseAuthApp.firebaseAuthApp
          .signin(emailAddressSignin.text.trim(), passwordSignin.text);

      if (uid != null) {
        isLoading = false;
        update();
        Get.offAll(ChooseTrip());
      }else {
        isLoading = false;
        update();
        return;
      }
    }

    isLoading = false;
    update();
  }
}
