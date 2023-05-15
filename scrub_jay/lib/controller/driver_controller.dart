import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:scrub_jay/core/firebase_app_auth.dart';
import 'package:scrub_jay/model/driver.dart';
import 'package:scrub_jay/model/trip.dart';
import 'package:scrub_jay/model/user.dart' as user;
import 'package:scrub_jay/view/Driver/DriverMainScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/app_shared_preferences.dart';
import '../model/map.dart' as map;

abstract class DriverController extends GetxController {
  Future<void> driverSignup();
  Future<void> addTrip();
  Future<void> getDriverData();
  Future<void> driverSignout();
  Future<void> getTrips();
  Future<void> determineCurrentLocation();
}

class DriverControllerImp extends DriverController {
  bool isLoading = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController fullName = TextEditingController();
  final TextEditingController emailAddress = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController rewritePassword = TextEditingController();
  final TextEditingController vehicleNumber = TextEditingController();
  final TextEditingController driverIdentityNumber = TextEditingController();
  final TextEditingController licenseNumber = TextEditingController();

  LatLng? currentLocation;
  Driver? currentDriver;
  List<LatLng> locations = [];
  List<Trip> trips = [];

  @override
  Future<void> determineCurrentLocation() async {
    await map.Map.getCurrentLocation().then((value) {
      currentLocation = LatLng(value.latitude, value.longitude);

      update();
    });
  }

  Future<void> getPassengersLocations() async {
    locations = [];
    if (trips.isNotEmpty) {
      Trip myTrip = trips.firstWhere((element) {
        return element.driverId == currentDriver!.id;
      });
      myTrip.passengers!.forEach((key, value) {
        locations.add(
          LatLng(
              value['location']!['latitude'], value['location']!['longitude']),
        );
      });
    }
    update();
  }

  @override
  Future<void> getTrips() async {
    isLoading = true;
    update();

    await Trip.getTrips().then(
      (value) async {
        value.onValue.listen(
          (event) async {
            trips = [];
            final Iterable<DataSnapshot> data = event.snapshot.children;
            for (DataSnapshot child in data) {
              final Map<String, dynamic> trip =
                  json.decode(json.encode(child.value));

              (await user.User.getUser(trip['driverId']))
                  .onValue
                  .listen((event) {
                trip['driverName'] =
                    (event.snapshot.value as Map<dynamic, dynamic>)['fullName'];
              });
              trip['id'] = child.key;

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
  driverSignup() async {
    isLoading = false;

    final bool isValid = formKey.currentState!.validate();

    if (isValid) {
      Driver newDriver = Driver(
          fullname: fullName.text.trim(),
          emailAddress: emailAddress.text.trim(),
          vehicleNumber: vehicleNumber.text,
          driverIdentityNumber: driverIdentityNumber.text,
          licenseNumber: licenseNumber.text,
          role: 1);

      final String? uid = await FirebaseAuthApp.firebaseAuthApp
          .signup(1, newDriver.toJson(), password.text);

      final bool setData =
          await AppSharedPrefernces.appSharedPrefernces.setData('role', 1);

      if (uid != null && setData) {
        isLoading = false;
        update();
        Get.offAll(() => const DriverMainScreen());
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
  Future driverSignout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Clear all the shared preferences
    await FirebaseAuthApp.firebaseAuthApp.signout(); // Sign out the user
    Get.offAllNamed('/Signin'); // Navigate to the login page
  }

  @override
  Future<void> addTrip() async {
    if (!isLoading) {
      Trip newTrip = Trip(
        driverId: currentDriver!.id,
        driverName: currentDriver!.fullname,
        phone: currentDriver!.phoneNumber,
        totalPassengers: 0,
      );

      await Trip.addTrip(newTrip).then((value) {});
    }
  }

  @override
  Future<void> getDriverData() async {
    String driverId = FirebaseAuth.instance.currentUser!.uid;
    isLoading = true;
    update();

    final DatabaseReference databaseReference =
        await user.User.getUser(driverId);

    databaseReference.onValue.listen(
      (event) {
        currentDriver =
            Driver.fromJson(json.decode(json.encode(event.snapshot.value)));

        currentDriver!.id = event.snapshot.key;
        isLoading = false;
      },
    );
  }

  @override
  void onInit() {
    super.onInit();
    getDriverData();
    getTrips();
    determineCurrentLocation();
  }
}
