import 'package:firebase_database/firebase_database.dart';

class FirebaseDatabaseApp {
  FirebaseDatabaseApp._();

  static FirebaseDatabaseApp firebaseDatabase = FirebaseDatabaseApp._();

  FirebaseDatabase initFirebaseDatabase() {
    return FirebaseDatabase.instance;
  }

  Future<DatabaseReference> getDatabaseRefrence(String path) async {
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
    final DatabaseReference ref = await getDatabaseRefrence(path);
    if (child != null) {
      return ref.child(child).get();
    }
    return ref.get();
  }

  Future<void> addData(String path, Map<String, dynamic> data) async {
    final DatabaseReference ref = await getDatabaseRefrence(path);
    await ref.set(data);
  }

  Future<void> updateData(String path, Map<String, dynamic> data) async {
    final DatabaseReference ref = await getDatabaseRefrence(path);
    await ref.update(data);
  }
}