import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageApp {
  FirebaseStorageApp._();
  static FirebaseStorageApp firebaseStorageApp = FirebaseStorageApp._();

  Future<String?> uploadFile(String? path, File file) async {
    final TaskSnapshot taskSnapshot =
        await FirebaseStorage.instance.ref(path).putFile(
              file,
            );
    final String fileUrl = await taskSnapshot.ref.getDownloadURL();
    return fileUrl;
  }
}
