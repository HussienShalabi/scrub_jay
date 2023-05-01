import 'package:scrub_jay/core/firebase_database_app.dart';

class Trip {
  String? id;
  String? passengerId;
  String? driverId;
  int? numOfPassengers;
  DateTime? date;

  Trip.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    passengerId = json['passengerId'];
    driverId = json['driverId'];
    numOfPassengers = json['numOfPassengers'];
    date = DateTime.tryParse(json['date']);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};

    json['id'] = id;
    json['passengerId'] = json['passengerId'];
    json['driverId'] = json['driverId'];
    json['numOfPassengers'] = json['numOfPassengers'];
    json['date'] = json['date'].toString();

    return json;
  }

  static Future<bool> addTrip(Trip trip) async =>
      await FirebaseDatabaseApp.firebaseDatabase
          .addData('trips', trip.toJson());
}
