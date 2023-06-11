import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:scrub_jay/core/app_apis.dart';
import 'package:scrub_jay/core/app_http.dart';
import 'package:scrub_jay/core/firebase_database_app.dart';
import 'package:scrub_jay/model/driver.dart';
import 'package:scrub_jay/model/passenger.dart';
import 'package:scrub_jay/model/trip.dart';
import 'package:scrub_jay/model/user.dart' as user;
import '../core/app_functions.dart';
import '../core/firebase_app_auth.dart';
import '../model/map.dart' as map;

abstract class DriverController extends GetxController {
  Future<void> getDriverData();
  Future<void> getTrips();
  Future<void> determineCurrentLocation();
  Future<void> startTrip();
}

class DriverControllerImp extends DriverController {
  bool isLoading = false;

  LatLng? currentLocation;
  Driver? currentDriver;
  List<Map<String, dynamic>> passengers = [];
  List<Trip> trips = [];
  bool getLocations = true;
  bool save = false;
  int indexTrip = 0;
  String myTripId = '';
  bool isGetInformation = false;

  final GlobalKey<FormState> updatePasswordFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyEdit = GlobalKey<FormState>();
  final TextEditingController oldPasswrod = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController rewritePassword = TextEditingController();
  final TextEditingController fullName = TextEditingController();
  final TextEditingController emailAddress = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();

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
    indexTrip = trips.length - 1;
    await FirebaseDatabaseApp.firebaseDatabase.updateData('trips/$myTripId', {
      'order': trip.order,
      'totalPassengers': 0,
      'passengers': [],
    });

    await FirebaseDatabaseApp.firebaseDatabase
        .deleteData('trips/$myTripId/passengers');

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

          final http.Response? response = await AppHttp.appHttp.getRequest(
            MapApis.geocodingApi(
              LatLng(value['location']!['latitude'],
                  value['location']!['longitude']),
            ),
          );

          final Map<String, dynamic> m = jsonDecode(response!.body);

          await databaseRefrence.get().then((snapshot) async {
            data = jsonDecode(jsonEncode(snapshot.value));
            data['id'] = snapshot.key;
            data['location'] = {
              'latitude': value['location']!['latitude'],
              'longitude': value['location']!['longitude'],
            };

            passengers.add({
              'passenger': Passenger.fromJson(data),
              'numOfPassenger': value['numOfPassengers'],
              'location_name': m['features'][0]['text'],
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

          if (dataSnapshot.value != null) {
            trip['driverName'] =
                (dataSnapshot.value as Map<dynamic, dynamic>)['fullName'];
            trip['id'] = child.key;
            trips.add(Trip.fromJson(trip));
            count++;
          }
        }
        isLoading = false;
        update();
      },
    );
  }

  @override
  Future<void> getDriverData() async {
    String driverId = FirebaseAuth.instance.currentUser!.uid;
    isGetInformation = true;
    update();

    final DatabaseReference? databaseReference =
        await user.User.getUser(driverId, role: 1);

    final DataSnapshot dataSnapshot = await databaseReference!.get();

    currentDriver =
        Driver.fromJson(json.decode(json.encode(dataSnapshot.value)));

    currentDriver!.id = dataSnapshot.key;

    isGetInformation = false;
    update();
    getTrips();
  }

  Future<void> editData() async {
    if (fullName.text.trim() != '') {
      currentDriver!.fullname = fullName.text.trim();
    }

    if (emailAddress.text.trim() != '') {
      currentDriver!.emailAddress = emailAddress.text.trim();
    }

    if (phoneNumber.text.trim() != '') {
      currentDriver!.phoneNumber = phoneNumber.text.trim();
    }

    final bool isValid = formKeyEdit.currentState!.validate();
    isLoading = true;
    if (isValid) {
      try {
        // Update the user's email
        User? userauth = await FirebaseAuthApp.firebaseAuthApp.currentUser();
        if (userauth != null && emailAddress.text.trim().isNotEmpty) {
          await userauth.updateEmail(emailAddress.text.trim());
          // await userauth.updatePassword(password.text);
        }

        // Update the user's password
        // await FirebaseAuth.instance.currentUser!.updatePassword(password.text);

        await FirebaseDatabaseApp.firebaseDatabase.updateData(
            'users/drivers/${currentDriver!.id}', currentDriver!.toJson());

        isLoading = false;
        update();
        Get.snackbar('Success', 'Profile has been updated');
      } on FirebaseAuthException catch (e) {
        Get.snackbar('Error', e.message ?? 'An error occurred');
      } catch (e) {
        Get.snackbar('Error', e.toString());
      }
    }
  }

  Future<void> updatePassword() async {
    isLoading = true;
    update();
    final bool isValid = updatePasswordFormKey.currentState!.validate();

    if (!isValid) {
      isLoading = false;
      update();
      return;
    }

    final String? uid = await FirebaseAuthApp.firebaseAuthApp.signin(
      currentDriver!.emailAddress!,
      oldPasswrod.text,
    );

    if (uid != null) {
      final User? user = await FirebaseAuthApp.firebaseAuthApp.currentUser();

      await user!.updatePassword(password.text);
      getxSnackbar('Success', 'Done!', backgroundColor: Colors.green);

      oldPasswrod.clear();
      password.clear();
      rewritePassword.clear();
    }

    isLoading = false;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    getDriverData();
    // getTrips();
    determineCurrentLocation();
  }
}
