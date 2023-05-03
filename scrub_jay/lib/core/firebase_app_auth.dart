import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:scrub_jay/core/app_shared_preferences.dart';
import 'package:scrub_jay/view/Passenger/ChooseTrip.dart';
import 'package:scrub_jay/view/admin/AdminMainScreen.dart';
import '../view/Driver/DriverMainScreen.dart';
import 'app_functions.dart';
import 'firebase_database_app.dart';

class FirebaseAuthApp {
  FirebaseAuthApp._();
  static FirebaseAuthApp firebaseAuthApp = FirebaseAuthApp._();

  // signup new user
  Future<String?> signup(
    int role,
    Map<String, dynamic> json,
    String password,
  ) async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    try {
      final UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
              email: json['emailAddress'], password: password);

      Map<String, dynamic> userInformation = {
        'username': json['fullname'],
        'phoneNumber': json['phoneNumber'],
        'email': ['email'],
        'role': role,
      };

      await FirebaseDatabaseApp.firebaseDatabase
          .addDataWithKey('users/${userCredential.user!.uid}', json);

      await firebaseAuth.verifyPhoneNumber(
        phoneNumber: '+97${json['phoneNumber']}',
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
          await firebaseAuth.signInWithCredential(phoneAuthCredential);
        },
        verificationFailed: (FirebaseAuthException error) {
          if (error.code == 'invalid-phone-number') {
            // print('The provided phone number is not valid.');
          }
        },
        codeSent: (String verificationId, int? forceResendingToken) async {
          String smsCode = '123456';

          // Create a PhoneAuthCredential with the code
          PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: verificationId,
            smsCode: smsCode,
          );

          // Sign the user in (or link) with the credential
          await firebaseAuth.signInWithCredential(credential);
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
      return userCredential.user!.uid;
    } on FirebaseAuthException catch (error) {
      getxSnackbar('error', error.code);
    }
    return null;
  }

  // signin user
  Future<String?> signin(String email, String password) async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    // FirebaseFirestore _firestore = FirebaseFirestore.instance;

    try {
      final UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      return userCredential.user!.uid;
      // final UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      // AppSharedPrefernces.appSharedPrefernces.getDate('role') as int?;
      // DocumentSnapshot userDoc = await _firestore.collection('users').doc('users/${userCredential.user!.uid}').get();
      // final userData = userDoc.data()as Map<String, dynamic>?; // Navigate to the appropriate screen based on the user role
      // if (userData != null) {
      //   final role = userData['role'] as int?;
      // if (role!=null){
      // switch (role) {
      //   case 0:
      //   // Admin screen
      //     Get.offAll(() => AdminMainScreen());
      //     break;
      //   case 1:
      //   // Regular user screen
      //     Get.offAll(() => DriverMainScreen());
      //     break;
      //   default:
      //   // Unknown user role
      //    Get.offAll(()=>ChooseTrip());
      // }}
      // else {}}
      // return userCredential.user!.uid;
    } on FirebaseAuthException catch (error) {
      getxSnackbar('error', error.code);
    }

    return null;
  }

  // signout
  Future<void> signout() async {
    await FirebaseAuth.instance.signOut();
  }

  // current user
  Future<User?> currentUser() async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    return currentUser;
  }
}
