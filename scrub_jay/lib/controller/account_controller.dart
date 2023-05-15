import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrub_jay/core/firebase_app_auth.dart';
import 'package:scrub_jay/core/firebase_database_app.dart';
import '../model/user.dart' as user;
import 'package:shared_preferences/shared_preferences.dart';

class AccountManagement extends GetxController {
  bool isLoading = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> formKeyEdit = GlobalKey<FormState>();
  final TextEditingController fullName = TextEditingController();
  final TextEditingController emailAddress = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController password = TextEditingController();

  user.User? currentUser;

  Future<void> editData() async {
    user.User? editedUser = user.User();

    editedUser.fullname = currentUser!.fullname == fullName.text.trim()
        ? null
        : fullName.text.trim();
    editedUser.phoneNumber = currentUser!.phoneNumber == phoneNumber.text.trim()
        ? null
        : phoneNumber.text.trim();
    editedUser.emailAddress =
        currentUser!.emailAddress == emailAddress.text.trim()
            ? null
            : emailAddress.text.trim();

    final bool isValid = formKeyEdit.currentState!.validate();
    isLoading = true;
    if (isValid) {
      try {
        // Update the user's email
        User? userauth = await FirebaseAuthApp.firebaseAuthApp.currentUser();
        if (userauth != null && editedUser.emailAddress != null) {
          await userauth.updateEmail(emailAddress.text.trim());
          // await userauth.updatePassword(password.text);
        }

        // Update the user's password
        await FirebaseAuth.instance.currentUser!.updatePassword(password.text);

        User? user = _auth.currentUser;
        // await FirebaseAuth.instance.
        await FirebaseDatabaseApp.firebaseDatabase
            .updateData('users/${user!.uid}', {
          'fullName': editedUser.fullname,
          'emailAddress': editedUser.emailAddress,
          'phoneNumber': editedUser.phoneNumber,
        });

        isLoading = false;
        update();
        // await user.updateEmail(newEmail);
        // await FirebaseDatabaseApp.firebaseDatabase.updateData(
        // 'users/$emailAddress',
        // emailAddress as Map<String, dynamic>
        // );
        Get.snackbar('Success', 'Profile has been updated');
      } on FirebaseAuthException catch (e) {
        Get.snackbar('Error', e.message ?? 'An error occurred');
      } catch (e) {
        log(e.toString());
        Get.snackbar('Error', e.toString());
      }
    }
  }

  // @override
  // Future<void> changeFullName () async {
  //   isLoading = true;
  //
  //   try {
  //     User? user = _auth.currentUser;
  //     // await FirebaseAuth.instance.
  //     await FirebaseDatabaseApp.firebaseDatabase.updateData(
  //         'users/${user!.uid}', {'fullName': fullName.text.trim()});
  //
  //     if (user.uid != null) {
  //       isLoading = false;
  //       update();
  //       // await user.updateEmail(newEmail);
  //       // await FirebaseDatabaseApp.firebaseDatabase.updateData(
  //       // 'users/$emailAddress',
  //       // emailAddress as Map<String, dynamic>
  //       // );
  //       Get.snackbar('Success', 'User name has been updated');
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     Get.snackbar('Error', e.message ?? 'An error occurred');
  //   } catch (e) {
  //     log(e.toString());
  //     Get.snackbar('Error', e.toString());
  //   }
  //
  // }
}
