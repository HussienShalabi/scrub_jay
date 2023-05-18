import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrub_jay/core/firebase_app_auth.dart';
import 'package:scrub_jay/core/firebase_database_app.dart';
import '../model/user.dart' as user;
import 'package:shared_preferences/shared_preferences.dart';

class AccountManagement extends GetxController {
  bool isLoading = false;

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

        User? user = await FirebaseAuthApp.firebaseAuthApp.currentUser();
        // await FirebaseAuth.instance.
        await FirebaseDatabaseApp.firebaseDatabase
            .updateData('users/${user!.uid}', {
          'fullName': editedUser.fullname,
          'emailAddress': editedUser.emailAddress,
          'phoneNumber': editedUser.phoneNumber,
        });

        isLoading = false;
        update();
        Get.snackbar('Success', 'Profile has been updated');
      } on FirebaseAuthException catch (e) {
        Get.snackbar('Error', e.message ?? 'An error occurred');
      } catch (e) {
        log(e.toString());
        Get.snackbar('Error', e.toString());
      }
    }
  }

  void deleteAccount() async {
    final currentUser = await FirebaseAuthApp.firebaseAuthApp.currentUser();

    Get.dialog(
      AlertDialog(
        title: const Text('Deactivate Account'),
        content:
            const Text('Are you sure you want to deactivate your account?'),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Get.back(); // Close the confirmation dialog
            },
          ),
          TextButton(
            child: const Text('Deactivate'),
            onPressed: () async {
              if (currentUser != null) {
                final userDoc = await FirebaseDatabaseApp.firebaseDatabase
                    .getData('users/${currentUser.uid}');

                // Delete user document from Firestore
                await userDoc.remove();

                // Delete user account from Firebase Authentication
                await currentUser.delete();

                // Sign out the user
                await FirebaseAuthApp.firebaseAuthApp.signout();
                Get.offAllNamed('/Signin');
              }
            },
          ),
        ],
      ),
    );
  }
}
