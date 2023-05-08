import 'package:scrub_jay/core/firebase_database_app.dart';
import 'package:scrub_jay/model/trip.dart';

class Order {
  String? id;
  String? passengerId;
  Map<String, double>? location;
  int? numOfPassengers;

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    passengerId = json['passengerId'];
    location = json['location'];
    numOfPassengers = json['numOfPassengers'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};

    json['passengerId'] = passengerId;
    json['location'] = location;
    json['numOfPassengers'] = numOfPassengers;

    return json;
  }

  static Future<void> addOrder(Order order) async {
    // logic
    await FirebaseDatabaseApp.firebaseDatabase.addDataWithKey(
      'trips/${Trip.trips[0].id}/passengers',
      order.toJson(),
    );
  }
}
