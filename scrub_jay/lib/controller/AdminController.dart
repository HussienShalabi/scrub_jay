import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class AbstractAdminController extends GetxController {
  final controller = Get.put(AdminController);
  void AddNewAdminButton();
}

class AdminController extends AbstractAdminController {
  late TextEditingController firstName;
  late TextEditingController lastName;
  late TextEditingController mobileNumber;
  late TextEditingController password;
  late TextEditingController reEnterPassword;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void AddNewAdminButton() {
    // TODO: implement AddNewAdminButton
  }
}
