import 'package:firebase_database/firebase_database.dart';
import 'package:scrub_jay/core/firebase_database_app.dart';

class Trip {
  String? id;
  String? phone;
  String? driverId;
  String? driverName;
  int? totalPassengers;
  DateTime? date;
  Map<String, dynamic>? passengers;

  Trip(
      {this.id,
      this.phone,
      this.driverId,
      this.driverName,
      this.passengers,
      this.totalPassengers,
      this.date});

  static List<Trip> trips = [];

  Trip.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phone = json['phone'];
    driverId = json['driverId'];
    passengers = json['passengers'] ?? {};
    driverName = json['driverName'];
    totalPassengers = json['totalPassengers'];

    trips.add(Trip(
      id: id,
      phone: phone,
      driverId: driverId,
      passengers: passengers,
      driverName: driverName,
      totalPassengers: totalPassengers,
    ));
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};

    json['id'] = id;
    json['phone'] = phone;
    json['driverId'] = driverId;
    json['passengers'] = passengers;
    json['driverName'] = driverName;
    json['totalPassengers'] = totalPassengers;

    return json;
  }

  static Future<bool> addTrip(Trip trip) async =>
      await FirebaseDatabaseApp.firebaseDatabase
          .addDataWithKey('trips', trip.toJson());

  static Future<DatabaseReference> getTrips() async =>
      await FirebaseDatabaseApp.firebaseDatabase.getData('trips');
}
