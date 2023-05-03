import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:scrub_jay/core/app_shared_preferences.dart';
import 'package:scrub_jay/core/firebase_app_auth.dart';
import 'package:scrub_jay/model/user.dart' as user;
import 'package:scrub_jay/model/passenger.dart';
import 'package:scrub_jay/model/trip.dart';
import 'package:scrub_jay/view/Passenger/ChooseTrip.dart';
import '../core/app_permissions.dart';

abstract class PassengerController extends GetxController {
  Future<void> passengerSignup();
  Future<void> passengerSignout();
  Future<void> orderTrip();
  Future<void> getTrips();
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

  List<Trip> trips = [];

  @override
  Future<void> getTrips() async {
    await Trip.trips().then(
      (value) async {
        for (DataSnapshot child in value.children) {
          final Map<String, dynamic> trip =
              json.decode(json.encode(child.value));

          final DataSnapshot dataSnapshot =
              await user.User.getUser(trip['driverId']);

          trip['driverName'] =
              (dataSnapshot.value as Map<dynamic, dynamic>)['fullName'];

          trips.add(Trip.fromJson(trip));
        }
      },
    );

    update();
  }

  @override
  Future<void> orderTrip() async {
    final User? user = await FirebaseAuthApp.firebaseAuthApp.currentUser();

    final Position position = await determinePosition();

    Trip trip = Trip.fromJson({
      'passengerId': user!.uid,
      'driverId': 'uid',
      'numOfPassengers': 5,
      'date': DateTime.now().toString(),
      'location': {
        'longitude': position.longitude,
        'latitude': position.latitude,
      },
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

  @override
  void onInit() {
    super.onInit();
    getTrips();
  }
}
