import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:scrub_jay/core/firebase_database_app.dart';
import 'package:scrub_jay/model/driver.dart';
import 'package:scrub_jay/model/passenger.dart';
import 'package:scrub_jay/model/trip.dart';
import 'package:scrub_jay/model/user.dart' as user;
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
    await FirebaseDatabaseApp.firebaseDatabase.updateData(
        'trips/$myTripId', {'order': trip.order, 'totalPassengers': 0});

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

  @override
  void onInit() {
    super.onInit();
    getDriverData();
    // getTrips();
    determineCurrentLocation();
  }
}
