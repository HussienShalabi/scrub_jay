import 'package:scrub_jay/model/user.dart';

class Passenger extends User {
  Map<String, dynamic>? location;

  Passenger(
      {this.location,
      super.fullname,
      super.emailAddress,
      super.phoneNumber,
      super.role});

  Passenger.fromJson(Map<String, dynamic> json) {
    super.id = json['id'];
    super.fullname = json['fullName'];
    super.emailAddress = json['emailAddress'];
    super.phoneNumber = json['phoneNumber'];
    super.role = json['role'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = super.id;
    data['fullName'] = super.fullname;
    data['emailAddress'] = super.emailAddress;
    data['phoneNumber'] = super.phoneNumber;
    data['location'] = location;
    data['role'] = super.role;
    return data;
  }
}
