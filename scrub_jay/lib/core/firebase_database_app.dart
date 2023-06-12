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

  Future<DatabaseEvent> orderTrips(String path) async {
    final ref = await getDatabaseReference(path);
    return ref.orderByChild('order').once();
  }

  Future<DatabaseReference> getData(String path, [String? child]) async {
    final ref = await getDatabaseReference(path);
    if (child != null) {
      return ref.child(child);
    }
    return ref;
  }

  Future<bool> addDataWithoutKey(String path, Map<String, dynamic> data) async {
    try {
      final DatabaseReference ref = await getDatabaseReference(path);
      await ref.set(data);

      return true;
    } catch (e) {
      getxSnackbar('Error', 'An error occurred');
      return false;
    }
  }

  Future<bool> addDataWithKey(String path, Map<String, dynamic> data) async {
    try {
      final DatabaseReference ref = await getDatabaseReference(path);
      await ref.push().set(data);

      return true;
    } catch (e) {
      getxSnackbar('Error', 'An error occurred');
      return false;
    }
  }

  Future<bool> setData(String path, Object? data) async {
    try {
      final DatabaseReference ref = await getDatabaseReference(path);
      await ref.set(data);

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

  Future<void> deleteData(String path) async {
    final DatabaseReference ref = await getDatabaseReference(path);
    await ref.remove();
  }
}
