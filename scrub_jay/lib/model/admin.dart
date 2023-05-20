import 'package:scrub_jay/model/user.dart';

class Admin extends User {
  Admin({
    super.fullname,
    super.emailAddress,
    super.phoneNumber,
    super.role,
  });

  // Serialization

  Admin.fromJson(Map<String, dynamic> json) {
    super.id = json['id'];
    super.fullname = json['fullName'];
    super.emailAddress = json['emailAddress'];
    super.phoneNumber = json['phoneNumber'];
    super.role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = super.id;
    data['fullName'] = super.fullname;
    data['emailAddress'] = super.emailAddress;
    data['phoneNumber'] = super.phoneNumber;
    data['role'] = super.role;
    return data;
  }
}
