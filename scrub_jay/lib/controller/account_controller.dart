import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrub_jay/core/firebase_app_auth.dart';
import 'package:scrub_jay/core/firebase_database_app.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AccountManagement extends GetxController{
  bool isLoading = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> formKeyEdit = GlobalKey<FormState>();
  final TextEditingController fullName = TextEditingController();
  final TextEditingController emailAddress = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController password = TextEditingController();

  Future<void> editData() async {
    final bool isValid = formKeyEdit.currentState!.validate();
    isLoading = true;
    if (isValid) {
      try {
        User? user = _auth.currentUser;
        // await FirebaseAuth.instance.
        await FirebaseDatabaseApp.firebaseDatabase.updateData(
            'users/${user!.uid}', {'fullName': fullName.text,'emailAddress': emailAddress.text.trim(),'phone': phoneNumber,'password': password.text });

        isLoading = false;
        update();
        // await user.updateEmail(newEmail);
        // await FirebaseDatabaseApp.firebaseDatabase.updateData(
        // 'users/$emailAddress',
        // emailAddress as Map<String, dynamic>
        // );
        Get.snackbar('Success', 'Email address has been updated');
      } on FirebaseAuthException catch (e) {
        Get.snackbar('Error', e.message ?? 'An error occurred');
      } catch (e) {
        log(e.toString());
        Get.snackbar('Error', e.toString());
      }
    }

  }

  @override
  Future<void> changeFullName () async {
    isLoading = true;

    try {
      User? user = _auth.currentUser;
      // await FirebaseAuth.instance.
      await FirebaseDatabaseApp.firebaseDatabase.updateData(
          'users/${user!.uid}', {'fullName': fullName.text.trim()});

      if (user.uid != null) {
        isLoading = false;
        update();
        // await user.updateEmail(newEmail);
        // await FirebaseDatabaseApp.firebaseDatabase.updateData(
        // 'users/$emailAddress',
        // emailAddress as Map<String, dynamic>
        // );
        Get.snackbar('Success', 'User name has been updated');
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.message ?? 'An error occurred');
    } catch (e) {
      log(e.toString());
      Get.snackbar('Error', e.toString());
    }

  }





}