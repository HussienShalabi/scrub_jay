import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrub_jay/core/firebase_app_auth.dart';
import 'package:scrub_jay/core/firebase_database_app.dart';
import 'package:scrub_jay/main.dart';
import 'package:scrub_jay/model/driver.dart';
import 'package:scrub_jay/model/passenger.dart';
import 'package:scrub_jay/view/Driver/DriverMainScreen.dart';
import 'package:scrub_jay/view/Passenger/ChooseTrip.dart';
import 'package:scrub_jay/view/common_screens/SignUpPassenger.dart';

import '../core/app_shared_preferences.dart';
import '../view/admin/AdminMainScreen.dart';

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
    // CollectionReference _usersCollection = FirebaseFirestore.instance.collection('users/uid');
    final bool isValid = formKeySignIn.currentState!.validate();
    isLoading = true;
    update();

    if (isValid) {
      final String? uid = await FirebaseAuthApp.firebaseAuthApp
          .signin(emailAddressSignin.text.trim(), passwordSignin.text);
      // AppSharedPrefernces.appSharedPrefernces.setData('role', 2);

      if (uid != null) {
        isLoading = false;
        update();
        // Get user data from Firestore
        // DocumentSnapshot userDoc = await _usersCollection.doc(uid).get();
        // Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
        Map<String, dynamic> userData = FirebaseDatabaseApp.firebaseDatabase.getData('users/uid') as Map<String, dynamic> ;

        // Store user role number in Shared Preferences
        AppSharedPrefernces.appSharedPrefernces.initSharedPred();
     final bool setData = await AppSharedPrefernces.appSharedPrefernces.setData('role', userData['role']);


        // Navigate to appropriate screen based on user role number
        if ( setData && userData['role'] == 1) {
          Get.offAll(()=>DriverMainScreen());
        } else if ( setData && userData['role']==2){
          Get.offAll(()=>ChooseTrip());
        }

        // Get.offAll(ChooseTrip());

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
