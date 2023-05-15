import 'package:scrub_jay/core/firebase_database_app.dart';
import 'package:scrub_jay/model/trip.dart';

class Order {
  String? id;
  String? passengerId;
  Map<String, double>? location;
  int? numOfPassengers;
  String? phone;

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    passengerId = json['passengerId'];
    location = json['location'];
    numOfPassengers = json['numOfPassengers'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};

    json['passengerId'] = passengerId;
    json['location'] = location;
    json['numOfPassengers'] = numOfPassengers;
    json['phone'] = phone;

    return json;
  }

  static Future<void> addOrder(Order order) async {
    String? tripId;
    int totalPassengers = 0;

    for (var trip in Trip.trips) {
      if (order.numOfPassengers! <= (7 - trip.passengers!.length)) {
        tripId = trip.id;
        totalPassengers =
            (order.numOfPassengers ?? 1) + (trip.totalPassengers ?? 0);
        break;
      }
    }
    if (tripId == null) {
      return;
    }

    await FirebaseDatabaseApp.firebaseDatabase.addDataWithKey(
      'trips/$tripId/passengers',
      order.toJson(),
    );

    await FirebaseDatabaseApp.firebaseDatabase.updateData(
      'trips/$tripId',
      {
        'totalPassengers': totalPassengers,
      },
    );
  }
}
