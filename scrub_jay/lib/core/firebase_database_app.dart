import 'package:firebase_database/firebase_database.dart';
import 'package:scrub_jay/core/app_functions.dart';

class FirebaseDatabaseApp {
  FirebaseDatabaseApp._();

  static FirebaseDatabaseApp firebaseDatabase = FirebaseDatabaseApp._();

  FirebaseDatabase initFirebaseDatabase() {
    return FirebaseDatabase.instance;
  }

  Future<DatabaseReference> getDatabaseReference(String path) async {
    return FirebaseDatabase.instance.ref(path);
  }

  // Future<String> addNewUser(
  //     String name, String email, String phone, String password) async {
  //   final UserCredential? userCredential =
  //       await firebaseAppAuth.signup(email, password);
  //   final String uid = userCredential!.user!.uid;

  //   await addData('users/$uid', {
  //     "name": name,
  //     "email": email,
  //     "phone": phone,
  //   });

  //   return uid;
  // }

  Future<DataSnapshot> getData(String path, [String? child]) async {
    final ref = await getDatabaseReference(path);
    if (child != null) {
      return ref.child(child).get();
    }
    return ref.get();
  }

  Future<bool> addDataWithKey(String path, Map<String, dynamic> data) async {
    try {
      final DatabaseReference ref = await getDatabaseReference(path);
      await ref.set(data);

      return true;
    } catch (e) {
      getxSnackbar('Error', 'An error occurred');
      return false;
    }
  }

  Future<bool> addDataWithoutKey(String path, Map<String, dynamic> data) async {
    try {
      final DatabaseReference ref = await getDatabaseReference(path);
      await ref.push().set(data);

      return true;
    } catch (e) {
      getxSnackbar('Error', 'An error occurred');
      return false;
    }
  }

  Future<void> updateData(String path, Map<String, dynamic> data) async {
    final DatabaseReference ref = await getDatabaseReference(path);
    await ref.update(data);
  }
}
