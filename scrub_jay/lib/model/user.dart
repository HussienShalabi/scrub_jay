import 'package:firebase_database/firebase_database.dart';
import 'package:scrub_jay/core/firebase_database_app.dart';

class User {
  String? id;
  String? fullname;
  String? emailAddress;
  String? phoneNumber;
  int? role;

  User({this.fullname, this.emailAddress, this.phoneNumber, this.role});

  static Future<DataSnapshot> getUser(String uid) async =>
      await FirebaseDatabaseApp.firebaseDatabase.getData('users/$uid');
}
