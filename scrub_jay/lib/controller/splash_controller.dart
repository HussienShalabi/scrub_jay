import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrub_jay/core/firebase_app_auth.dart';
import 'package:scrub_jay/model/driver.dart';
import 'package:scrub_jay/model/passenger.dart';
import 'package:scrub_jay/view/Passenger/ChooseTrip.dart';
import 'package:scrub_jay/view/common_screens/SignUpPassenger.dart';
import 'package:scrub_jay/view/common_screens/Signin.dart';
import 'package:scrub_jay/view/common_screens/SplashScreen.dart';

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
       isVisible =
         true;

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