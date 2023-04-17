import 'package:scrub_jay/model/user.dart';

class Passenger extends User {
Map<String, String>? location;
int? numberOfPassenger;

Passenger( {this.location, this.numberOfPassenger, super.fullname,  super.phoneNumber,  super.role});

Passenger.fromJson(Map<String, dynamic> json) {
  super.id = json['id'];
  super.fullname = json['fullName'];
  super.phoneNumber = json['phoneNumber'];
  super.role = json['role'];
  location = json['location'];
  numberOfPassenger = json['numberOfPassenger'];
}

Map<String, dynamic> toJson() {
  final Map<String, dynamic> data =  Map<String, dynamic>();
  data['id'] =  super.id ;
  data['fullName'] =  super.fullname;
  data['phoneNumber'] =  super.phoneNumber ;
    data['location'] = location;
  data['numberOfPassenger'] = numberOfPassenger;
  data['role'] = super.role;
  return data;
}
}