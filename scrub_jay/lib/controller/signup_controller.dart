import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrub_jay/core/firebase_app_auth.dart';
import 'package:scrub_jay/model/driver.dart';
import 'package:scrub_jay/model/passenger.dart';
import 'package:scrub_jay/view/common_screens/SignUp.dart';

abstract class SignUpController extends GetxController with GetSingleTickerProviderStateMixin{
  Future<void> signup();
}

class SignUpControllerImp extends SignUpController {

  late TabController tabController;
  late int value;
  int selectedTab = 0;

 final GlobalKey<FormState> formKey = GlobalKey<FormState>();

 final TextEditingController fullname = TextEditingController();
 final TextEditingController phoneNumber = TextEditingController();
 final TextEditingController password = TextEditingController();
 final TextEditingController rewritePassword = TextEditingController();

 @override
  void onInit() {
   tabController = TabController(length: 2, vsync: this);
    super.onInit();
  }

  @override
  void update([List<Object>? ids, bool condition = true]) {
    selectedTab = value;
    super.update(ids, condition);
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  @override
  signup() async {
    final bool isValid = formKey.currentState!.validate();

    if (isValid && selectedTab ==0 ) {
      Passenger newPassenger = Passenger(fullname: fullname.text.trim(), phoneNumber: phoneNumber.text.trim(), role: 2);
      final String? uid = await FirebaseAuthApp.firebaseAuthApp.signup(2, newPassenger.toJson(), password.text);

      print(uid);
    }else if (isValid && selectedTab ==1 ) {
      Driver newDriver = Driver(fullname: fullname.text.trim(), phoneNumber: phoneNumber.text.trim(),role: 1);
      final String? uid = await FirebaseAuthApp.firebaseAuthApp.signup(1, newDriver.toJson(), password.text);
    }
  }


}