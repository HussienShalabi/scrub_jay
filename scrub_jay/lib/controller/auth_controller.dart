// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrub_jay/core/app_functions.dart';
import 'package:scrub_jay/core/firebase_database_app.dart';
import 'package:scrub_jay/model/admin.dart';
import 'package:scrub_jay/view/admin/AdminMainScreen.dart';
import 'package:scrub_jay/view/common_screens/Signin.dart';
import '../core/app_shared_preferences.dart';
import '../core/firebase_app_auth.dart';
import '../model/driver.dart';
import '../model/passenger.dart';
import '../model/trip.dart';
import '../model/user.dart' as user;
import '../view/Driver/DriverMainScreen.dart';
import '../view/passenger/choose_trip.dart';

abstract class AuthController extends GetxController {
  Future<void> signIn();
  Future<void> signout();
  Future<void> passengerSignup();
  Future<void> driverSignup();
  Future<void> adminSignup();
}

class AuthControllerImp extends AuthController {
  bool isLoading = false;
  final GlobalKey<FormState> signupPassengerKey = GlobalKey<FormState>();
  final GlobalKey<FormState> signupDriverKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeySignIn = GlobalKey<FormState>();
  final GlobalKey<FormState> createAdminKey = GlobalKey<FormState>();
  final GlobalKey<FormState> signInKey = GlobalKey<FormState>();
  TextEditingController? fullName;
  TextEditingController? emailAddress;
  TextEditingController? phoneNumber;
  TextEditingController? password;
  TextEditingController? rewritePassword;
  TextEditingController? vehicleNumber;
  TextEditingController? driverIdentityNumber;
  TextEditingController? licenseNumber;
  final RxInt roleSelected = RxInt(2);

  clearData() {
    fullName!.clear();
    emailAddress!.clear();
    phoneNumber!.clear();
    password!.clear();
    rewritePassword!.clear();
    vehicleNumber!.clear();
    driverIdentityNumber!.clear();
    licenseNumber!.clear();
  }

  initilizeData() {
    fullName = TextEditingController();
    emailAddress = TextEditingController();
    phoneNumber = TextEditingController();
    password = TextEditingController();
    rewritePassword = TextEditingController();
    vehicleNumber = TextEditingController();
    driverIdentityNumber = TextEditingController();
    licenseNumber = TextEditingController();
  }

  @override
  Future<void> signIn() async {
    final bool isValid = formKeySignIn.currentState!.validate();
    isLoading = true;
    update();

    if (isValid) {
      final String? uid = await FirebaseAuthApp.firebaseAuthApp
          .signin(emailAddress!.text.trim(), password!.text);

      if (uid != null) {
        final DatabaseReference? databaseReference =
            await user.User.getUser(uid, role: roleSelected.value);

        if (databaseReference == null) {
          getxSnackbar('Failed Sign In', 'An error has occurred');
          return;
        }

        final DataSnapshot data = await databaseReference.get();

        if (data.value == null) {
          getxSnackbar('Failed Sign In', 'Your are not allowed to enter');
          isLoading = false;
          update();
          return;
        }

        final bool setData = await AppSharedPrefernces.appSharedPrefernces
            .setData('role', roleSelected.value);

        if (setData && roleSelected.value == 1) {
          if ((jsonDecode(jsonEncode(data.value)))['isConfirm'] == false) {
            getxSnackbar(
                'Failed Sign In', 'Admin not confirmed your account yet');

            await AppSharedPrefernces.appSharedPrefernces.deleteData('role');
            isLoading = false;
            update();
            return;
          }

          Get.offAll(() => DriverMainScreen());
        } else if (setData && roleSelected.value == 2) {
          Get.offAll(() => ChooseTrip());
        } else if (setData && roleSelected.value == 0) {
          // final Object? data =
          //     AppSharedPrefernces.appSharedPrefernces.getDate('order_trips');

          // if (data == null) {
          //   await AppSharedPrefernces.appSharedPrefernces
          //       .setData('order_trips', {
          //     'times': 1,
          //     'date': DateTime.now().toString(),
          //   });
          // } else {
          //   final Map<String, dynamic> map = jsonDecode(jsonEncode(data));
          //   if (DateTime.now()
          //           .difference(DateTime.tryParse(map['date'])!)
          //           .inHours >=
          //       24) {
          //     await AppSharedPrefernces.appSharedPrefernces
          //         .setData('order_trips', {
          //       'times': 1,
          //       'date': DateTime.now().toString(),
          //     });
          //   }
          // }

          Get.offAll(() => const AdminMainScreen());
        }
      }
    }

    isLoading = false;
    update();
  }

  @override
  Future<void> passengerSignup() async {
    final bool isValid = signupPassengerKey.currentState!.validate();
    isLoading = true;
    update();

    if (isValid) {
      Passenger newPassenger = Passenger(
        fullname: fullName!.text.trim(),
        emailAddress: emailAddress!.text.trim(),
        phoneNumber: phoneNumber!.text.trim(),
        role: 2,
      );

      final String? uid = await FirebaseAuthApp.firebaseAuthApp
          .signup(2, newPassenger.toJson(), password!.text);

      if (uid != null) {
        isLoading = false;
        update();

        await FirebaseAuthApp.firebaseAuthApp.signout();
        Get.offAll(() => const Signin());
      }
    }

    isLoading = false;
    update();
  }

  @override
  Future<void> driverSignup() async {
    isLoading = true;
    update();

    final bool isValid = signupDriverKey.currentState!.validate();

    if (isValid) {
      Driver newDriver = Driver(
        fullname: fullName!.text.trim(),
        emailAddress: emailAddress!.text.trim(),
        phoneNumber: phoneNumber!.text.trim(),
        vehicleNumber: vehicleNumber!.text.trim(),
        driverIdentityNumber: driverIdentityNumber!.text.trim(),
        licenseNumber: licenseNumber!.text.trim(),
        role: 1,
      );

      final DatabaseReference databaseReference =
          await FirebaseDatabaseApp.firebaseDatabase.getData('maxOrder');
      final DataSnapshot dataSnapshot = await databaseReference.get();
      int? maxOrder = dataSnapshot.value as int?;

      if (maxOrder == null) {
        maxOrder = 1;
        await FirebaseDatabase.instance.ref('maxOrder').set(maxOrder);
      } else {
        maxOrder = maxOrder + 1;
      }

      await FirebaseDatabase.instance.ref('maxOrder').set(maxOrder);

      final String? uid = await FirebaseAuthApp.firebaseAuthApp
          .signup(1, newDriver.toJson(), password!.text);

      Trip trip = Trip(
        phone: newDriver.phoneNumber,
        driverId: uid,
        totalPassengers: 0,
        order: maxOrder,
      );

      await FirebaseDatabaseApp.firebaseDatabase.addDataWithKey(
        'trips',
        trip.toJson(),
      );

      await FirebaseAuthApp.firebaseAuthApp.signout();

      if (uid != null) {
        isLoading = false;
        update();
        Get.offAll(() => const Signin());
      }
    }

    isLoading = false;
    update();
  }

  @override
  Future<void> signout() async {
    await FirebaseAuthApp.firebaseAuthApp.signout();
    await AppSharedPrefernces.appSharedPrefernces.deleteData('role');
    Get.offAll(() => const Signin());
  }

  @override
  Future<void> adminSignup() async {
    isLoading = false;

    final bool isValid = createAdminKey.currentState!.validate();

    if (isValid) {
      Admin newAdmin = Admin(
        fullname: fullName!.text.trim(),
        emailAddress: emailAddress!.text.trim(),
        phoneNumber: phoneNumber!.text.trim(),
        role: 0,
      );

      final String? uid = await FirebaseAuthApp.firebaseAuthApp
          .signup(0, newAdmin.toJson(), password!.text);

      await FirebaseAuthApp.firebaseAuthApp.signout();

      if (uid != null) {
        isLoading = false;
        update();
        Get.offAll(() => const AdminMainScreen());
      }
    }

    isLoading = false;
    update();
  }

  Future<void> forgetPassword() async {
    isLoading = true;
    update();

    final List<String> list = await FirebaseAuth.instance
        .fetchSignInMethodsForEmail(emailAddress!.text);

    if (list.isEmpty) {
      isLoading = false;
      update();
      getxSnackbar('Error', 'Email not found');
      return;
    } else {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailAddress!.text);

      isLoading = false;
      update();
      getxSnackbar('Success', 'We send link password reset to your email',
          backgroundColor: Colors.green);
      Get.off(() => const Signin());
    }
  }

  void updateSelectedValue(int value) {
    roleSelected.value = value;
    update();
  }

  Future<void> f() async {
    final DatabaseReference databaseReference =
        await FirebaseDatabaseApp.firebaseDatabase.getData('maxOrder');
    final DataSnapshot dataSnapshot = await databaseReference.get();
    int? maxOrder = dataSnapshot.value as int?;

    if (maxOrder == null) {
      maxOrder = 1;
      await FirebaseDatabase.instance.ref('maxOrder').set(maxOrder);
    }
  }

  @override
  void onInit() {
    super.onInit();
    initilizeData();
    f();
  }
}
