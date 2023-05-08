import 'package:scrub_jay/model/user.dart';

class Driver extends User {
  String? vehicleNumber;
  String? insuranceDriverImageURL;
  String? insuranceCarImageURL;

  Driver(
      {this.vehicleNumber,
      this.insuranceDriverImageURL,
      this.insuranceCarImageURL,
      super.fullname,
      super.emailAddress,
      super.phoneNumber,
      super.role});

  Driver.fromJson(Map<String, dynamic> json) {
    super.id = json['id'];
    super.fullname = json['fullName'];
    super.emailAddress = json['emailAddress'];
    super.phoneNumber = json['phoneNumber'];
    super.role = json['role'];
    insuranceDriverImageURL = json['insuranceDriverImageURL'];
    insuranceCarImageURL = json['insuranceCarImageURL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = super.id;
    data['fullName'] = super.fullname;
    data['emailAddress'] = super.emailAddress;
    data['phoneNumber'] = super.phoneNumber;
    data['insuranceDriverImageURL'] = insuranceDriverImageURL;
    data['insuranceCarImageURL'] = insuranceCarImageURL;
    data['role'] = super.role;
    return data;
  }
}
