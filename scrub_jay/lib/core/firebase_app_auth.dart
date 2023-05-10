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
      final UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
              email: json['emailAddress'], password: password);

      await FirebaseDatabaseApp.firebaseDatabase
          .addDataWithKey('users/${userCredential.user!.uid}', json);

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

      return userCredential.user!.uid;
      // final UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      // AppSharedPrefernces.appSharedPrefernces.getDate('role') as int?;
      // DocumentSnapshot userDoc = await _firestore.collection('users').doc('users/${userCredential.user!.uid}').get();
      // final userData = userDoc.data()as Map<String, dynamic>?; // Navigate to the appropriate screen based on the user role
      // if (userData != null) {
      //   final role = userData['role'] as int?;
      // if (role!=null){
      // switch (role) {
      //   case 0:
      //   // Admin screen
      //     Get.offAll(() => AdminMainScreen());
      //     break;
      //   case 1:
      //   // Regular user screen
      //     Get.offAll(() => DriverMainScreen());
      //     break;
      //   default:
      //   // Unknown user role
      //    Get.offAll(()=>ChooseTrip());
      // }}
      // else {}}
      // return userCredential.user!.uid;
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
