import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrub_jay/core/app_shared_preferences.dart';
import 'package:scrub_jay/core/firebase_app_auth.dart';
import 'package:scrub_jay/model/driver.dart';
import 'package:scrub_jay/model/passenger.dart';
import 'package:scrub_jay/view/Passenger/ChooseTrip.dart';
import 'package:scrub_jay/view/common_screens/SignUpPassenger.dart';

abstract class PassengerController extends GetxController {
  Future<void> passengerSignup();
}

class PassengerControllerImp extends PassengerController {
  bool isLoading = false;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController fullName = TextEditingController();
  final TextEditingController emailAddress = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController rewritePassword = TextEditingController();

  final GlobalKey<FormState> formKeySignIn = GlobalKey<FormState>();
  final TextEditingController emailAddressSignin = TextEditingController();
  final TextEditingController passwordSignin = TextEditingController();

  @override
  passengerSignup() async {
    final bool isValid = formKey.currentState!.validate();
    isLoading = true;
    update();


    if (isValid) {
      Passenger newPassenger = Passenger(
          fullname: fullName.text.trim(),
          emailAddress: emailAddress.text.trim(),
          role: 2);
      final String? uid = await FirebaseAuthApp.firebaseAuthApp
          .signup(2, newPassenger.toJson(), password.text);

      final bool setData = await AppSharedPrefernces.appSharedPrefernces.setData('role', 2);

      if (uid != null && setData) {
        isLoading = false;
        update();
        Get.offAll(ChooseTrip());
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
}
