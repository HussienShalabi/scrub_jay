import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'app_functions.dart';
import 'firebase_database_app.dart';

class FirebaseAuthApp {
  FirebaseAuthApp._();
  static FirebaseAuthApp firebaseAuthApp = FirebaseAuthApp._();

  // signup new user
  Future<String?> signup(
    int role,
    Map<String, dynamic> json,
    String password,
  ) async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    try {
      final UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
              email: json['emailAddress'], password: password);

      await userCredential.user!.sendEmailVerification();

      await FirebaseDatabaseApp.firebaseDatabase
          .addDataWithoutKey('users/${userCredential.user!.uid}', json);

      getxSnackbar(
        'Success',
        'We are send email verification',
        backgroundColor: Colors.green,
      );

      return userCredential.user!.uid;
    } on FirebaseAuthException catch (error) {
      getxSnackbar('error', error.code);
    }
    return null;
  }

  // signin user
  Future<String?> signin(String email, String password) async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    // FirebaseFirestore _firestore = FirebaseFirestore.instance;

    try {
      final UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      if (!userCredential.user!.emailVerified) {
        getxSnackbar('error', 'your account not verified');
        return null;
      }

      return userCredential.user!.uid;
    } on FirebaseAuthException catch (error) {
      getxSnackbar('error', error.code);
    }

    return null;
  }

  // signout
  Future<void> signout() async {
    await FirebaseAuth.instance.signOut();
  }

  // current user
  Future<User?> currentUser() async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    return currentUser;
  }
}
