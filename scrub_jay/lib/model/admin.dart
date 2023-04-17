import 'package:scrub_jay/model/user.dart';

class Admin extends User {


  Admin.fromJson(Map<String, dynamic> json) {
    super.id = json['id'];
    super.fullname = json['fullName'];
    super.phoneNumber = json['phoneNumber'];
    super.role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] =  super.id ;
    data['fullName'] =  super.fullname;
    data['phoneNumber'] =  super.phoneNumber ;
     data['role'] = super.role ;
    return data;
  }
}