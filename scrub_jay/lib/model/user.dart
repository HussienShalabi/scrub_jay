import 'package:firebase_database/firebase_database.dart';
import 'package:scrub_jay/core/firebase_database_app.dart';

class User {
  String? id;
  String? fullname;
  String? emailAddress;
  String? phoneNumber;
  int? role;

  User({this.fullname, this.emailAddress, this.phoneNumber, this.role});

  static Future<DatabaseReference?> getUser(String uid, {int? role}) async {
    if (role != null) {
      final String path = role == 0
          ? 'users/admins'
          : role == 1
              ? 'users/drivers'
              : 'users/passengers';

      return await FirebaseDatabaseApp.firebaseDatabase.getData('$path/$uid');
    }
    return null;
  }
}
