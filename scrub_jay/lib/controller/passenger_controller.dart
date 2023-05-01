import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrub_jay/core/app_shared_preferences.dart';
import 'package:scrub_jay/core/firebase_app_auth.dart';
import 'package:scrub_jay/model/passenger.dart';
import 'package:scrub_jay/model/trip.dart';
import 'package:scrub_jay/view/Passenger/ChooseTrip.dart';

abstract class PassengerController extends GetxController {
  Future<void> passengerSignup();
  Future<void> passengerSignout();
  Future<void> orderTrip();
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
  Future<void> orderTrip() async {
    Trip trip = Trip.fromJson({
      'passengerId': 'uid',
      'driverId': 'uid',
      'numberOfPassenger': 5,
      'date': DateTime.now().toString(),
    });

    await Trip.addTrip(trip);
  }

  @override
  passengerSignup() async {
    final bool isValid = formKey.currentState!.validate();
    isLoading = true;
    update();

    if (isValid) {
      Passenger newPassenger = Passenger(
          fullname: fullName.text.trim(),
          emailAddress: emailAddress.text.trim(),
          phoneNumber: phoneNumber.text.trim(),
          role: 2);

      final String? uid = await FirebaseAuthApp.firebaseAuthApp
          .signup(2, newPassenger.toJson(), password.text);

      final bool setData =
          await AppSharedPrefernces.appSharedPrefernces.setData('role', 2);

      if (uid != null && setData) {
        isLoading = false;
        update();

        Get.offAll(() => ChooseTrip());
      } else {
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
  Future passengerSignout() async {
    await FirebaseAuthApp.firebaseAuthApp.signout(); // Sign out the user
    await AppSharedPrefernces.appSharedPrefernces.deleteData('role');
    Get.offAllNamed('/Signin'); // Navigate to the login page
  }
}
