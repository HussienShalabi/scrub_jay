.import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseAppMessaging {
  FirebaseAppMessaging._();

  static FirebaseAppMessaging firebaseAppMessaging = FirebaseAppMessaging._();
  FirebaseMessaging? _firebaseMessaging;

  Future<void> initFirebaseMessaging() async {
    _firebaseMessaging = FirebaseMessaging.instance;

    await _firebaseMessaging!.getToken().then((value) {
      print("token: " + value.toString());
    });
    await _firebaseMessaging!.setAutoInitEnabled(true);

    await _firebaseMessaging!.requestPermission();

    FirebaseMessaging.onMessage.listen((event) {
      print('Hello!');
    });
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      print('Opened!');
    });
  }
}
