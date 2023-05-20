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

  static Future<int?> addOrder(List<Trip> trips, Order order) async {
    String? tripId;
    int index = 0;
    int totalPassengers = 0;

    for (var trip in trips) {
      if (order.numOfPassengers! <= (7 - trip.totalPassengers!)) {
        tripId = trip.id;
        totalPassengers =
            (order.numOfPassengers ?? 1) + (trip.totalPassengers ?? 0);
        trip.totalPassengers = totalPassengers;
        break;
      }
      index++;
    }
    if (tripId == null) {
      return null;
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

    return index;
  }
}
