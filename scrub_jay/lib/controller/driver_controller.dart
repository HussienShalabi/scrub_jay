import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrub_jay/core/firebase_app_auth.dart';
import 'package:scrub_jay/model/driver.dart';
import 'package:scrub_jay/model/trip.dart';
import 'package:scrub_jay/view/Driver/DriverMainScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/app_shared_preferences.dart';
import '../core/firebase_app_auth.dart';

abstract class DriverController extends GetxController {
  Future<void> driverSignup();
  Future<void> addTrip();
  Future<void> getDriverData();
}

class DriverControllerImp extends DriverController {
  bool isLoading = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController fullName = TextEditingController();
  final TextEditingController emailAddress = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController rewritePassword = TextEditingController();

  @override
  driverSignup() async {
     isLoading = false;

    final bool isValid = formKey.currentState!.validate();

    if (isValid) {
      Driver newDriver = Driver(
          fullname: fullName.text.trim(),
          emailAddress: emailAddress.text.trim(),
          role: 1);

      final String? uid = await FirebaseAuthApp.firebaseAuthApp
          .signup(1, newDriver.toJson(), password.text);

      final bool setData = await AppSharedPrefernces.appSharedPrefernces.setData('role', 1);

      if (uid != null && setData) {
        isLoading = false;
        update();
        Get.offAll(() => const DriverMainScreen());
      }else {
        await FirebaseAuthApp.firebaseAuthApp.signout();
        isLoading = false;
        update();
        return;
      }
    }

    isLoading = false;
    update();
    }
  @override
  Future driverSignout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Clear all the shared preferences
    await FirebaseAuthApp.firebaseAuthApp.signout(); // Sign out the user
    Get.offAllNamed('/Signin'); // Navigate to the login page

  }
  
  @override
  Future<void> addTrip() async {
    Trip newTrip = Trip(
    //driverId: getDriverData
    ); 
    
  }
  
  @override
  Future<void> getDriverData() async {
    String DriverId=FirebaseAuth.instance.currentUser!.uid;
    
    
  }
}
