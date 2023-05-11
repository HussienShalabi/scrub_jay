import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrub_jay/core/firebase_app_auth.dart';
import 'package:scrub_jay/core/firebase_database_app.dart';
import 'package:scrub_jay/model/user.dart';
import 'package:scrub_jay/view/Driver/DriverMainScreen.dart';
import '../view/passenger/choose_trip.dart';

import '../core/app_shared_preferences.dart';

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

        DataSnapshot data = await (await User.getUser(uid)).get();
        final bool setData = await AppSharedPrefernces.appSharedPrefernces
            .setData('role', (data.value as Map<dynamic, dynamic>)['role']);

        if (setData && (data.value as Map<dynamic, dynamic>)['role'] == 1) {
          Get.offAll(() => const DriverMainScreen());
        } else if (setData &&
            (data.value as Map<dynamic, dynamic>)['role'] == 2) {
          Get.offAll(() => ChooseTrip());
        }

        // Get.offAll(ChooseTrip());
      } else {
        isLoading = false;
        update();
        print('hiiiiiiiii');
        return;
      }
    }

    isLoading = false;
    update();
  }
}
