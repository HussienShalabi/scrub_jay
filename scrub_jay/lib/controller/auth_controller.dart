import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrub_jay/model/admin.dart';
import 'package:scrub_jay/view/admin/AdminMainScreen.dart';
import 'package:scrub_jay/view/common_screens/Signin.dart';
import '../core/firebase_app_auth.dart';
import '../model/driver.dart';
import '../model/passenger.dart';

abstract class AuthController extends GetxController {
  Future<void> signIn();
  Future<void> signout();
  Future<void> passengerSignup();
  Future<void> driverSignup();
  Future<void> AdminSignup();
}

class AuthControllerImp extends AuthController {
  bool isLoading = false;
  GlobalKey<FormState> signupPassengerKey = GlobalKey<FormState>();
  GlobalKey<FormState> signupDriverKey = GlobalKey<FormState>();
  GlobalKey<FormState> createAdminKey = GlobalKey<FormState>();
  GlobalKey<FormState> signInKey = GlobalKey<FormState>();
  TextEditingController fullName = TextEditingController();
  TextEditingController emailAddress = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController rewritePassword = TextEditingController();
  TextEditingController vehicleNumber = TextEditingController();
  TextEditingController driverIdentityNumber = TextEditingController();
  TextEditingController licenseNumber = TextEditingController();

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
  Future<void> signIn() async {}

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
  void onClose() {
    super.onClose();
    clearData();
  }

  @override
  Future<void> AdminSignup() async {
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
}
