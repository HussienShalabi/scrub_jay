import 'package:firebase_database/firebase_database.dart';
import 'package:scrub_jay/core/firebase_database_app.dart';

class Trip {
  String? id;
  String? phone;
  String? driverId;
  String? driverName;
  Map<String, dynamic>? passengers;

  Trip({this.id, this.phone, this.driverId, this.driverName, this.passengers});

  static List<Trip> trips = [];

  Trip.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phone = json['phone'];
    driverId = json['driverId'];
    passengers = json['passengers'] ?? {};
    driverName = json['driverName'];

    trips.add(Trip(
      id: id,
      phone: phone,
      driverId: driverId,
      passengers: passengers,
      driverName: driverName,
    ));
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};

    json['id'] = id;
    json['phone'] = phone;
    json['driverId'] = driverId;
    json['passengers'] = passengers;

    return json;
  }

  static Future<bool> addTrip(Trip trip) async =>
      await FirebaseDatabaseApp.firebaseDatabase
          .addDataWithKey('trips', trip.toJson());

  static Future<DataSnapshot> getTrips() async =>
      await FirebaseDatabaseApp.firebaseDatabase.getData('trips');
}
