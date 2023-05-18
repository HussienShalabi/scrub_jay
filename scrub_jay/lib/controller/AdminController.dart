import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrub_jay/model/driver.dart';
import '../model/user.dart' as user;
import '../core/firebase_app_auth.dart';
import '../core/firebase_database_app.dart';
import '../model/admin.dart';
import '../view/admin/AdminMainScreen.dart';

abstract class AbstractAdminController extends GetxController {

  Driver? currentDriver;

  Future<void> adminSignup();
  final controller = Get.put(AdminControllerImp);
}

class AdminControllerImp extends AbstractAdminController {
  bool isLoading = false;

  GlobalKey<FormState> createAdminKey = GlobalKey<FormState>();

  TextEditingController fullName = TextEditingController();
  TextEditingController emailAddress = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController rewritePassword = TextEditingController();

  clearData() {
    fullName.dispose();
    emailAddress.dispose();
    phoneNumber.dispose();
    password.dispose();
    rewritePassword.dispose();
  }


  @override
  Future<void> adminSignup() async {
    isLoading = false;

    final bool isValid = createAdminKey.currentState!.validate();

    if (isValid) {
      try {
        Admin newAdmin = Admin(
          fullname: fullName.text.trim(),
          emailAddress: emailAddress.text.trim(),
          phoneNumber: phoneNumber.text.trim(),
          role: 0,
        );

        final String? uid = await FirebaseAuthApp.firebaseAuthApp
            .signup(0, newAdmin.toJson(), password.text);

        await FirebaseAuthApp.firebaseAuthApp.signout();

        if (uid != null) {
          isLoading = false;
          update();
          Get.offAll(() => const AdminMainScreen());
          Get.snackbar('Success', 'Admin Account has been created');
        }
      } on FirebaseAuthException catch (e) {
        Get.snackbar('Error', e.message ?? 'An error occurred');
      } catch (e) {
        log(e.toString());
        Get.snackbar('Error', e.toString());
      }
    }

    isLoading = false;
    update();
  }



  @override
  void onInit() {
    super.onInit();
    adminSignup();

  }
}
