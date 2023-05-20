import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:scrub_jay/core/firebase_app_auth.dart';
import 'package:scrub_jay/core/firebase_database_app.dart';
import 'package:scrub_jay/model/driver.dart';
import 'package:scrub_jay/model/passenger.dart';
import 'package:scrub_jay/model/trip.dart';
import 'package:scrub_jay/model/user.dart' as user;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/map.dart' as map;

abstract class DriverController extends GetxController {
  Future<void> addTrip();
  Future<void> getDriverData();
  Future<void> driverSignout();
  Future<void> getTrips();
  Future<void> determineCurrentLocation();
  Future<void> startTrip();
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
  List<Map<String, dynamic>> passengers = [];
  List<Trip> trips = [];
  bool getLocations = true;
  bool save = false;
  int indexTrip = 0;
  String myTripId = '';

  @override
  Future<void> determineCurrentLocation() async {
    await map.Map.getCurrentLocation().then((value) {
      currentLocation = LatLng(value.latitude, value.longitude);

      update();
    });
  }

  @override
  Future<void> startTrip() async {
    save = true;
    update();
    Trip trip = trips[indexTrip];

    trip.order = trips[trips.length - 1].order! + 1;
    trips.removeAt(indexTrip);
    trips.add(trip);
    await FirebaseDatabaseApp.firebaseDatabase
        .updateData('trips/$myTripId', {'order': trip.order});

    save = false;
    update();
  }

  Future<void> getPassengersLocations() async {
    if (trips.isNotEmpty) {
      Trip myTrip = trips.firstWhere((element) {
        return element.id == myTripId;
      });
      myTrip.passengers!.forEach(
        (key, value) async {
          Map<String, dynamic> data = {};
          final DatabaseReference databaseRefrence = await FirebaseDatabaseApp
              .firebaseDatabase
              .getData('users/passengers/${value['passengerId']}');

          passengers = [];
          await databaseRefrence.get().then((snapshot) {
            data = jsonDecode(jsonEncode(snapshot.value));
            data['id'] = snapshot.key;
            data['location'] = {
              'latitude': value['location']!['latitude'],
              'longitude': value['location']!['longitude'],
            };

            passengers.add({
              'passenger': Passenger.fromJson(data),
              'numOfPassenger': value['numOfPassengers']
            });
            getLocations = false;
            update();
          });
        },
      );
    }
  }

  @override
  Future<void> getTrips() async {
    int count = 0;
    isLoading = true;
    String driverId = FirebaseAuth.instance.currentUser!.uid;
    update();

    await Trip.getTrips().then(
      (value) async {
        trips = [];

        for (DataSnapshot child in value) {
          final Map<String, dynamic> trip =
              json.decode(json.encode(child.value));

          if (trip['driverId'] == driverId) {
            myTripId = child.key!;
            indexTrip = count;
          }

          final DatabaseReference? databaseReference =
              await user.User.getUser(trip['driverId'], role: 1);

          final DataSnapshot dataSnapshot = await databaseReference!.get();

          trip['driverName'] =
              (dataSnapshot.value as Map<dynamic, dynamic>)['fullName'];
          trip['id'] = child.key;
          trips.add(Trip.fromJson(trip));
          count++;
        }
        isLoading = false;
        update();
      },
    );
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

    final DatabaseReference? databaseReference =
        await user.User.getUser(driverId, role: 1);

    databaseReference!.onValue.listen(
      (event) {
        currentDriver =
            Driver.fromJson(json.decode(json.encode(event.snapshot.value)));

        currentDriver!.id = event.snapshot.key;
        update();
      },
    ).onData((data) {
      getTrips();
    });
  }

  @override
  void onInit() {
    super.onInit();
    getDriverData();
    // getTrips();
    determineCurrentLocation();
  }
}
