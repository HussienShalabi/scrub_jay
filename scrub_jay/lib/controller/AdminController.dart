import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrub_jay/model/driver.dart';
import '../core/firebase_app_auth.dart';
import '../core/firebase_database_app.dart';
import '../model/admin.dart';
import '../view/admin/AdminMainScreen.dart';

abstract class AbstractAdminController extends GetxController {
  Future<void> adminSignup();
  Future<void> getDrivers();
  Future<void> swap();
  Future<void> deleteDriver(String id);
  //Future<void> deleteDriver();
  final controller = Get.put(AdminControllerImp);
}

class AdminControllerImp extends AbstractAdminController {
  bool isLoading = false;

  List<Driver> drivers = [];

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
  Future<void> deleteDriver(String id) async {
    await FirebaseDatabaseApp.firebaseDatabase.deleteData('users/drivers/$id');
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
    getDrivers();
  }

  @override
  Future<void> getDrivers() async {
    DatabaseReference driversData =
        await FirebaseDatabaseApp.firebaseDatabase.getData("users/drivers");
    await driversData.get().then((value) {
      for (var element in value.children) {
        final Map<String, dynamic> json = jsonDecode(jsonEncode(element.value));
        drivers.add(Driver.fromJson(json));
      }
      update();
    });
  }

  @override
  Future<void> swap() async {
    var newIndex;
    var oldIndex;
    if (newIndex > oldIndex) newIndex--;
  }
}
