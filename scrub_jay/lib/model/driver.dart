import 'package:scrub_jay/model/user.dart';

class Driver extends User {
  String? vehicleNumber;
  String? driverIdentityNumber;
  String? licenseNumber;
  bool? isConfirm;

  Driver(
      {this.vehicleNumber,
      this.driverIdentityNumber,
      this.licenseNumber,
      super.fullname,
      super.emailAddress,
      super.phoneNumber,
      super.role,
      this.isConfirm = false});

  Driver.fromJson(Map<String, dynamic> json) {
    super.id = json['id'];
    super.fullname = json['fullName'];
    super.emailAddress = json['emailAddress'];
    super.phoneNumber = json['phoneNumber'];
    super.role = json['role'];
    vehicleNumber = json['vehicleNumber'];
    driverIdentityNumber = json['driverIdentityNumber'];
    licenseNumber = json['licenseNumber'];
    isConfirm = json['isConfirm'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['fullName'] = super.fullname;
    data['emailAddress'] = super.emailAddress;
    data['phoneNumber'] = super.phoneNumber;
    data['vehicleNumber'] = vehicleNumber;
    data['driverIdentityNumber'] = driverIdentityNumber;
    data['licenseNumber'] = licenseNumber;
    data['role'] = super.role;
    data['isConfirm'] = isConfirm;
    return data;
  }
}
