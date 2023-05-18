import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrub_jay/core/app_functions.dart';
import 'package:scrub_jay/model/admin.dart';
import 'package:scrub_jay/view/admin/AdminMainScreen.dart';
import 'package:scrub_jay/view/common_screens/Signin.dart';
import '../core/app_shared_preferences.dart';
import '../core/firebase_app_auth.dart';
import '../model/driver.dart';
import '../model/passenger.dart';
import '../model/user.dart';
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
  final TextEditingController fullName = TextEditingController();
  final TextEditingController emailAddress = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController rewritePassword = TextEditingController();
  final TextEditingController vehicleNumber = TextEditingController();
  final TextEditingController driverIdentityNumber = TextEditingController();
  final TextEditingController licenseNumber = TextEditingController();
  final RxInt roleSelected = RxInt(2);

  clearData() {
    fullName.dispose();
    emailAddress.dispose();
    phoneNumber.dispose();
    password.dispose();
    rewritePassword.dispose();
    vehicleNumber.dispose();
    driverIdentityNumber.dispose();
    licenseNumber.dispose();
  }

  @override
  Future<void> signIn() async {
    final bool isValid = formKeySignIn.currentState!.validate();
    isLoading = true;
    update();

    if (isValid) {
      final String? uid = await FirebaseAuthApp.firebaseAuthApp
          .signin(emailAddress.text.trim(), password.text);

      if (uid != null) {
        isLoading = false;
        update();

        final DatabaseReference? databaseReference =
            await User.getUser(uid, role: roleSelected.value);

        if (databaseReference == null) {
          getxSnackbar('Failed Sign In', 'An error has occurred');
          return;
        }

        final DataSnapshot data = await databaseReference.get();

        if (data.value == null) {
          getxSnackbar('Failed Sign In', 'Your are not allowed to enter');
          return;
        }

        final bool setData = await AppSharedPrefernces.appSharedPrefernces
            .setData('role', roleSelected.value);

        if (setData && roleSelected.value == 1) {
          Get.offAll(() => const DriverMainScreen());
        } else if (setData && roleSelected.value == 2) {
          Get.offAll(() => ChooseTrip());
        } else if (setData && roleSelected.value == 0) {
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
        fullname: fullName.text.trim(),
        emailAddress: emailAddress.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        role: 2,
      );

      final String? uid = await FirebaseAuthApp.firebaseAuthApp
          .signup(2, newPassenger.toJson(), password.text);

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
    isLoading = false;

    final bool isValid = signupDriverKey.currentState!.validate();

    if (isValid) {
      Driver newDriver = Driver(
        fullname: fullName.text.trim(),
        emailAddress: emailAddress.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        vehicleNumber: vehicleNumber.text.trim(),
        driverIdentityNumber: driverIdentityNumber.text.trim(),
        licenseNumber: licenseNumber.text.trim(),
        role: 1,
      );

      final String? uid = await FirebaseAuthApp.firebaseAuthApp
          .signup(1, newDriver.toJson(), password.text);

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
  Future<void> signout() async {}

  @override
  Future<void> adminSignup() async {
    isLoading = false;

    final bool isValid = createAdminKey.currentState!.validate();

    if (isValid) {
      Admin newAdmin = Admin(
        fullname: fullName.text.trim(),
        emailAddress: emailAddress.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        role: 0,
      );

      final String? uid = await FirebaseAuthApp.firebaseAuthApp
          .signup(0, newAdmin.toJson(), password.text);

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

  void updateSelectedValue(int value) {
    roleSelected.value = value;
    update();
  }

  @override
  void onClose() {
    super.onClose();
    clearData();
  }
}
