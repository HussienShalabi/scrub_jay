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
    Trip? trip;
    int index = 0;
    int totalPassengers = 0;

    for (var t in trips) {
      if (order.numOfPassengers! <= (7 - t.totalPassengers!)) {
        trip = t;
        totalPassengers =
            (order.numOfPassengers ?? 1) + (t.totalPassengers ?? 0);
        t.totalPassengers = totalPassengers;
        break;
      }
      index++;
    }
    if (trip == null) {
      return null;
    }

    await FirebaseDatabaseApp.firebaseDatabase.addDataWithKey(
      'trips/${trip.id}/passengers',
      order.toJson(),
    );

    await FirebaseDatabaseApp.firebaseDatabase.updateData(
      'trips/${trip.id}',
      {
        'totalPassengers': totalPassengers,
      },
    );

    await FirebaseDatabaseApp.firebaseDatabase.addDataWithKey(
      'notifications/${trip.driverId}',
      {'title': 'Scrub Jay', 'message': 'There are new passengers', 'read': 0},
    );

    return index;
  }
}
