import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:scrub_jay/core/firebase_app_auth.dart';
import 'package:scrub_jay/core/firebase_database_app.dart';
import 'package:scrub_jay/model/order.dart';
import 'package:scrub_jay/model/user.dart' as user;
import 'package:scrub_jay/model/passenger.dart';
import 'package:scrub_jay/model/trip.dart';
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

          trip['driverName'] =
              (dataSnapshot.value as Map<dynamic, dynamic>)['fullName'];
          trip['id'] = child.key;
          trips.add(Trip.fromJson(trip));
        }
        isLoading = false;
        update();
      },
    );
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

  @override
  void onInit() {
    super.onInit();
    getInformation();
    getTrips();
    determineCurrentLocation();
  }
}
