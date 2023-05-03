import 'package:firebase_database/firebase_database.dart';
import 'package:scrub_jay/core/firebase_database_app.dart';

class Trip {
  String? id;
  String? phone;
  String? driverId;
  String? driverName;
  List? passengers;

  Trip.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phone = json['phone'];
    driverId = json['driverId'];
    passengers = json['passengers'];
    driverName = json['driverName'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};

    json['id'] = id;
    json['phone'] = phone;
    json['driverId'] = driverId;
    json['passengers'] = passengers;
    json['driverName'] = driverName;

    return json;
  }

  static Future<bool> addTrip(Trip trip) async =>
      await FirebaseDatabaseApp.firebaseDatabase
          .addDataWithoutKey('trips', trip.toJson());

  static Future<DataSnapshot> trips() async =>
      await FirebaseDatabaseApp.firebaseDatabase.getData('trips');
}
