import 'package:firebase_auth/firebase_auth.dart';
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
      final UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: 'example4@gmail.com', password: password);

      Map<String, dynamic> userInformation = {
        'username': json['fullname'],
        'phoneNumber': json['phoneNumber'],
        'email': ['email'],
      };

      String? userType;

      if(role == 0) {
        userType = 'admins';
      }
      else if(role == 1) {
        userType = 'drivers';
      }
      else {
        userType = 'passengers';
      }


      await FirebaseDatabaseApp.firebaseDatabase.addData('users/$userType/${userCredential.user!.uid}', json);


      await firebaseAuth.verifyPhoneNumber(
        phoneNumber: '+97${json['phoneNumber']}',
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
          await firebaseAuth.signInWithCredential(phoneAuthCredential);
        },
        verificationFailed: (FirebaseAuthException error) {
          if (error.code == 'invalid-phone-number') {
            // print('The provided phone number is not valid.');
          }
        },

        codeSent: (String verificationId, int? forceResendingToken) async {
          String smsCode = '123456';

          // Create a PhoneAuthCredential with the code
          PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: verificationId,
            smsCode: smsCode,
          );

          // Sign the user in (or link) with the credential
          await firebaseAuth.signInWithCredential(credential);
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
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

    try {
      final UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      // final UserCredential userCredential =
      //     await firebaseAuth.signInWithPhoneNumber(phoneNumber);
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
