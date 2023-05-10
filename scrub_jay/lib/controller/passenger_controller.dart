import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:scrub_jay/core/app_shared_preferences.dart';
import 'package:scrub_jay/core/firebase_app_auth.dart';
import 'package:scrub_jay/model/order.dart';
import 'package:scrub_jay/model/user.dart' as user;
import 'package:scrub_jay/model/passenger.dart';
import 'package:scrub_jay/model/trip.dart';
import '../view/passenger/choose_trip.dart';
import '../model/map.dart' as map;

abstract class PassengerController extends GetxController {
  Future<void> passengerSignup();
  Future<void> passengerSignout();
  Future<void> orderTrip();
  Future<void> getTrips();
}

class PassengerControllerImp extends PassengerController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController fullName = TextEditingController();
  final TextEditingController emailAddress = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController rewritePassword = TextEditingController();
  final GlobalKey<FormState> formKeySignIn = GlobalKey<FormState>();
  final TextEditingController emailAddressSignin = TextEditingController();
  final TextEditingController passwordSignin = TextEditingController();

  bool isLoading = false;
  int numberOfPassengers = 1;
  List<Trip> trips = [];
  LatLng? currentLocation;

  @override
  Future<void> getTrips() async {
    isLoading = true;
    update();

    await Trip.getTrips().then(
      (value) async {
        value.onValue.listen(
          (event) async {
            final Iterable<DataSnapshot> data = event.snapshot.children;
            for (DataSnapshot child in data) {
              final Map<String, dynamic> trip =
                  json.decode(json.encode(child.value));

              (await user.User.getUser(trip['driverId']))
                  .onValue
                  .listen((event) {
                trip['id'] = child.key;
                trip['driverName'] =
                    (event.snapshot.value as Map<dynamic, dynamic>)['fullName'];
              });

              trips.add(Trip.fromJson(trip));
            }
            isLoading = false;
            update();
          },
        );
      },
    );
  }

  @override
  Future<void> orderTrip() async {
    final User? user = await FirebaseAuthApp.firebaseAuthApp.currentUser();

    if (currentLocation == null) {
      await map.Map.getCurrentLocation().then(
          (value) => currentLocation = LatLng(value.latitude, value.longitude));
    }

    Order order = Order.fromJson({
      'passengerId': user!.uid,
      'location': {
        'longitude': currentLocation!.longitude,
        'latitude': currentLocation!.latitude,
      },
      'numOfPassengers': numberOfPassengers,
    });

    // Trip trip = Trip.fromJson({
    //   'passengerId': user!.uid,
    //   'driverId': 'uid',
    //   'numOfPassengers': numberOfPassengers,
    //   'date': DateTime.now().toString(),
    //   'location': {
    //     'longitude': currentLocation!.longitude,
    //     'latitude': currentLocation!.latitude,
    //   },
    // });

    await Order.addOrder(order);
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

  void selectNumberOfPassenger(value) {
    numberOfPassengers = value;
    update();
  }

  RxInt optionMapSelected = RxInt(0);

  void updateSelectedValue(int value) {
    optionMapSelected.value = value;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    getTrips();
  }
}
