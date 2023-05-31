import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrub_jay/core/app_functions.dart';
import 'package:scrub_jay/model/driver.dart';
import 'package:scrub_jay/model/trip.dart';
import '../core/firebase_app_auth.dart';
import '../core/firebase_database_app.dart';
import '../model/user.dart' as user;
import '../model/admin.dart';
import '../view/admin/AdminMainScreen.dart';

abstract class AbstractAdminController extends GetxController {
  Future<void> adminSignup();
  Future<void> getDrivers();
  Future<void> getTrips();
  Future<void> deleteDriver(int index, String id);
  Future<void> confirmDriver(int index, String id);
  Future<void> reorder(int oldIndex, int newIndex);
  final controller = Get.put(AdminControllerImp);
}

class AdminControllerImp extends AbstractAdminController {
  bool isLoading = false;
  bool isGetInformation = false;

  Admin? currentAdmin;
  List<Driver> drivers = [];
  List<Driver> newDrivers = [];
  List<Trip> trips = [];
  int orderTimes = 1;

  GlobalKey<FormState> createAdminKey = GlobalKey<FormState>();
  GlobalKey<FormState> updatePasswordFormKey = GlobalKey<FormState>();

  TextEditingController fullName = TextEditingController();
  TextEditingController emailAddress = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController oldPasswrod = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController rewritePassword = TextEditingController();

  clearData() {
    fullName.dispose();
    emailAddress.dispose();
    phoneNumber.dispose();
    password.dispose();
    rewritePassword.dispose();
  }

  Future<void> getInformation() async {
    isGetInformation = true;
    update();

    final User? user = await FirebaseAuthApp.firebaseAuthApp.currentUser();

    final DatabaseReference databaseReference = await FirebaseDatabaseApp
        .firebaseDatabase
        .getData('users/admins/${user!.uid}');
    await databaseReference.get().then((value) {
      final Map<String, dynamic> data = jsonDecode(jsonEncode(value.value));

      data['id'] = user.uid;

      currentAdmin = Admin.fromJson(data);
    });
    isGetInformation = false;
    update();
  }

  @override
  Future<void> adminSignup() async {
    isLoading = false;

    final bool isValid = createAdminKey.currentState!.validate();

    if (isValid) {
      try {
        Admin newAdmin = Admin(
          fullname: fullName.text.trim(),
          emailAddress: emailAddress.text.trim(),
          phoneNumber: phoneNumber.text.trim(),
          role: 0,
        );

        final String? uid = await FirebaseAuthApp.firebaseAuthApp
            .signup(0, newAdmin.toJson(), password.text);

        await FirebaseAuthApp.firebaseAuthApp.signout();

        if (uid != null) {
          isLoading = false;
          update();
          Get.offAll(() => const AdminMainScreen());
          Get.snackbar('Success', 'Admin Account has been created');
        }
      } on FirebaseAuthException catch (e) {
        Get.snackbar('Error', e.message ?? 'An error occurred');
      } catch (e) {
        log(e.toString());
        Get.snackbar('Error', e.toString());
      }
    }

    clearData();

    isLoading = false;
    update();
  }

  @override
  Future<void> getDrivers() async {
    DatabaseReference driversData =
        await FirebaseDatabaseApp.firebaseDatabase.getData("users/drivers");
    await driversData.get().then((value) {
      for (var element in value.children) {
        final Map<String, dynamic> json = jsonDecode(jsonEncode(element.value));
        json['id'] = element.key;
        if (json['isConfirm']) {
          drivers.add(Driver.fromJson(json));
        } else {
          newDrivers.add(Driver.fromJson(json));
        }
      }
      update();
    });
  }

  @override
  Future<void> reorder(int oldIndex, int newIndex) async {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    if (trips.isNotEmpty) {
      final Trip trip = trips.removeAt(oldIndex);
      trips.insert(newIndex, trip);
    } else {
      final Driver item = drivers.removeAt(oldIndex);
      drivers.insert(newIndex, item);
    }

    for (int i = newIndex; i < trips.length; i++) {
      trips[i].order = trips[i - 1].order! + 1;
    }

    update();
  }

  Future<void> saveTrips() async {
    isLoading = true;
    update();
    int index = 1;

    if (trips.isEmpty) {
      for (Driver driver in drivers) {
        Trip trip = Trip(
          phone: driver.phoneNumber,
          driverId: driver.id,
          totalPassengers: 0,
          order: index,
        );
        await FirebaseDatabaseApp.firebaseDatabase.addDataWithKey(
          'trips',
          trip.toJson(),
        );
        index++;
      }
    } else {
      for (Trip trip in trips) {
        await FirebaseDatabaseApp.firebaseDatabase.updateData(
          'trips/${trip.id}',
          trip.toJson(),
        );
      }
    }

    isLoading = false;
    update();
  }

  @override
  Future<void> deleteDriver(int index, String id) async {
    await FirebaseDatabaseApp.firebaseDatabase.deleteData('users/drivers/$id');
    update();
  }

  @override
  Future<void> confirmDriver(int index, String id) async {
    final Driver driver = newDrivers[index];
    driver.isConfirm = true;

    await FirebaseDatabaseApp.firebaseDatabase.updateData('users/drivers/$id', {
      'isConfirm': driver.isConfirm,
    });

    drivers.add(driver);
    newDrivers.remove(driver);
    update();
  }

  @override
  Future<void> getTrips() async {
    isLoading = true;
    update();

    await Trip.getTrips().then(
      (value) async {
        trips = [];

        for (DataSnapshot child in value) {
          final Map<String, dynamic> trip =
              json.decode(json.encode(child.value));

          final DatabaseReference? databaseReference =
              await user.User.getUser(trip['driverId'], role: 1);

          final DataSnapshot dataSnapshot = await databaseReference!.get();

          trip['driverName'] =
              (dataSnapshot.value as Map<dynamic, dynamic>)['fullName'];
          trip['id'] = child.key;
          trips.add(Trip.fromJson(trip));
        }
        isLoading = false;
        update();
      },
    );
  }

  Future<void> updatePassword() async {
    isLoading = true;
    update();
    final bool isValid = updatePasswordFormKey.currentState!.validate();

    if (!isValid) {
      isLoading = false;
      update();
      return;
    }

    final String? uid = await FirebaseAuthApp.firebaseAuthApp.signin(
      currentAdmin!.emailAddress!,
      oldPasswrod.text,
    );

    if (uid != null) {
      final User? user = await FirebaseAuthApp.firebaseAuthApp.currentUser();

      await user!.updatePassword(password.text);
      getxSnackbar('Success', 'Done!', backgroundColor: Colors.green);

      oldPasswrod.clear();
      password.clear();
      rewritePassword.clear();
    }

    isLoading = false;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    getInformation();
    getDrivers();
    getTrips();
  }
}
