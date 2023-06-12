import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:scrub_jay/core/firebase_app_auth.dart';
import 'package:scrub_jay/core/firebase_database_app.dart';
import 'package:scrub_jay/model/order.dart';
import 'package:scrub_jay/model/user.dart' as user;
import 'package:scrub_jay/model/passenger.dart';
import 'package:scrub_jay/model/trip.dart';
import '../core/app_functions.dart';
import '../core/app_notifications.dart';
import '../model/map.dart' as map;

abstract class PassengerController extends GetxController {
  Future<void> orderTrip();
  Future<void> getTrips();
}

class PassengerControllerImp extends PassengerController {
  RxInt optionMapSelected = RxInt(0);

  bool permissionMap = false;
  bool isLoading = false;
  int numberOfPassengers = 1;
  List<Trip> trips = [];
  LatLng? currentLocation;
  LatLng? destinationLocation;
  Passenger? currentPassenger;

  final GlobalKey<FormState> formKeyEdit = GlobalKey<FormState>();
  final GlobalKey<FormState> updatePasswordFormKey = GlobalKey<FormState>();
  final TextEditingController fullName = TextEditingController();
  final TextEditingController emailAddress = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController oldPasswrod = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController rewritePassword = TextEditingController();

  bool done = false;

  void isDone(bool value) {
    done = value;
    update();
  }

  Future<void> getInformation() async {
    isLoading = true;
    update();

    final User? user = await FirebaseAuthApp.firebaseAuthApp.currentUser();

    final DatabaseReference databaseReference = await FirebaseDatabaseApp
        .firebaseDatabase
        .getData('users/passengers/${user!.uid}');
    await databaseReference.get().then((value) {
      final Map<String, dynamic> data = jsonDecode(jsonEncode(value.value));

      data['id'] = user.uid;

      currentPassenger = Passenger.fromJson(data);
    });
    isLoading = false;
    update();
  }

  Future<void> determineCurrentLocation() async =>
      await map.Map.getCurrentLocation().then((value) {
        currentLocation = LatLng(value.latitude, value.longitude);
        update();
      });

  @override
  Future<void> getTrips() async {
    isLoading = true;
    update();

    await Trip.getTrips().then(
      (value) async {
        trips = [];

        for (DataSnapshot child in value) {
          final Map<String, dynamic> trip =
              json.decode(json.encode(child.value));

          final DatabaseReference? databaseReference =
              await user.User.getUser(trip['driverId'], role: 1);

          final DataSnapshot dataSnapshot = await databaseReference!.get();

          if (dataSnapshot.value != null) {
            trip['driverName'] =
                (dataSnapshot.value as Map<dynamic, dynamic>)['fullName'];
            trip['id'] = child.key;
            trips.add(Trip.fromJson(trip));
          }
        }
        isLoading = false;
        update();
      },
    );
  }

  Future<void> editData() async {
    if (fullName.text.trim() != '') {
      currentPassenger!.fullname = fullName.text.trim();
    }

    if (emailAddress.text.trim() != '') {
      currentPassenger!.emailAddress = emailAddress.text.trim();
    }

    if (phoneNumber.text.trim() != '') {
      currentPassenger!.phoneNumber = phoneNumber.text.trim();
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
            'users/passengers/${currentPassenger!.id}',
            currentPassenger!.toJson());

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
      currentPassenger!.emailAddress!,
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

  Future<void> selectDestination(LatLng position) async {
    destinationLocation = position;
    update();
  }

  @override
  Future<void> orderTrip() async {
    isLoading = true;
    update();

    Order order = Order.fromJson({
      'passengerId': currentPassenger!.id,
      'location': {
        'longitude': optionMapSelected.value == 0
            ? currentLocation!.longitude
            : destinationLocation!.longitude,
        'latitude': optionMapSelected.value == 0
            ? currentLocation!.latitude
            : destinationLocation!.latitude,
      },
      'numOfPassengers': numberOfPassengers,
      'phone': currentPassenger!.phoneNumber,
    });

    await Order.addOrder(trips, order);

    isLoading = false;
    update();
    Get.back();
  }

  void selectNumberOfPassenger(value) {
    numberOfPassengers = value;
    update();
  }

  void updateSelectedValue(int value) {
    optionMapSelected.value = value;
    update();
  }

  Future<void> getNotifications() async {
    final DatabaseReference databaseReference = await FirebaseDatabaseApp
        .firebaseDatabase
        .getData('notifications/${currentPassenger!.id}');

    databaseReference.onValue.listen((event) {
      for (var noti in event.snapshot.children) {
        Map<String, dynamic> data = jsonDecode(jsonEncode(noti.value));
        if (data['read'] == 0) {
          AppNotifications.appNotifications
              .showNotification(title: data['title'], body: data['message']);
          FirebaseDatabaseApp.firebaseDatabase.updateData(
              'notifications/${currentPassenger!.id}/${noti.key}', {'read': 1});
        }
      }
    });
  }

  @override
  void onInit() {
    super.onInit();
    determineCurrentLocation();
    getTrips();
    getInformation().then((value) {
      getNotifications();
    });
  }
}
