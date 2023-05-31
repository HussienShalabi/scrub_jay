import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrub_jay/controller/auth_controller.dart';
import 'package:scrub_jay/controller/passenger_controller.dart';
import 'package:scrub_jay/core/app_shared_preferences.dart';
import 'package:scrub_jay/core/firebase_app_auth.dart';
import 'package:scrub_jay/view/admin/AdminMainScreen.dart';
import 'package:scrub_jay/view/common_screens/EditPassword.dart';
import 'package:scrub_jay/view/common_screens/settingsScreen.dart';
import 'package:scrub_jay/view/passenger/PassengerMap.dart';
import 'package:scrub_jay/view/passenger/PassengerProfile.dart';
import '../common_screens/Signin.dart';
import '../common_screens/chooseLang.dart';

class PassengerDrawer extends StatelessWidget {
  const PassengerDrawer({super.key});

  final double _drawerIconSize = 18;

  final double _drawerFontSize = 17;

  @override
  Widget build(BuildContext context) {
    final PassengerControllerImp controllerImp =
        Get.put(PassengerControllerImp());

    return Drawer(
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: const [
              0.0,
              1.0
            ],
                colors: [
              Theme.of(context).primaryColor.withOpacity(0.2),
              Theme.of(context).colorScheme.secondary.withOpacity(0.5),
            ])),
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: const [0.0, 1.0],
                  colors: [
                    Theme.of(context).primaryColor,
                    Theme.of(context).colorScheme.secondary,
                  ],
                ),
              ),
              child: SizedBox(
                child: Center(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Text(
                        controllerImp.currentPassenger == null
                            ? 'username'
                            : controllerImp.currentPassenger!.fullname ??
                                'username',
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // ListTile(
            //   leading: Icon(Icons.person,
            //       size: _drawerIconSize,
            //       color: Theme.of(context).colorScheme.secondary),
            //   title: Text(
            //     'Profile Page'.tr,
            //     style: TextStyle(
            //         fontSize: _drawerFontSize,
            //         color: Theme.of(context).colorScheme.secondary),
            //   ),
            //   onTap: () {},
            // ),
            // ListTile(
            //   leading: Icon(Icons.lock_person_rounded,
            //       size: _drawerIconSize,
            //       color: Theme.of(context).colorScheme.secondary),
            //   title: Text(
            //     'Edit password'.tr,
            //     style: TextStyle(
            //         fontSize: _drawerFontSize,
            //         color: Theme.of(context).colorScheme.secondary),
            //   ),
            //   onTap: () {
            //     Get.to( EditPassword());
            //   },
            // ),

            ListTile(
              leading: Icon(Icons.person,
                  size: _drawerIconSize,
                  color: Theme.of(context).colorScheme.secondary),
              title: Text(
                'Profile page'.tr,
                style: TextStyle(
                    fontSize: _drawerFontSize,
                    color: Theme.of(context).colorScheme.secondary),
              ),
              onTap: () {
                Get.to(PassengerProfile());
              },
            ),
            ListTile(
              leading: Icon(Icons.settings,
                  size: _drawerIconSize,
                  color: Theme.of(context).colorScheme.secondary),
              title: Text(
                'Account management'.tr,
                style: TextStyle(
                    fontSize: _drawerFontSize,
                    color: Theme.of(context).colorScheme.secondary),
              ),
              onTap: () {
                Get.to(SettingsScreen());
              },
            ),

            ListTile(
              leading: Icon(Icons.translate_rounded,
                  size: _drawerIconSize,
                  color: Theme.of(context).colorScheme.secondary),
              title: Text(
                'Change language'.tr,
                style: TextStyle(
                    fontSize: _drawerFontSize,
                    color: Theme.of(context).colorScheme.secondary),
              ),
              onTap: () {
                Get.to(chooseLang());
              },
            ),
            // ListTile(
            //   leading: Icon(
            //     Icons.map,
            //     size: _drawerIconSize,
            //     color: Theme.of(context).colorScheme.secondary,
            //   ),
            //   title: Text(
            //     'Passenger Map'.tr,
            //     style: TextStyle(
            //         fontSize: _drawerFontSize,
            //         color: Theme.of(context).colorScheme.secondary),
            //   ),
            //   onTap: () {
            //     Get.to(const PassengerMap());
            //   },
            // ),
            ListTile(
              leading: Icon(
                Icons.logout_rounded,
                size: _drawerIconSize,
                color: Theme.of(context).colorScheme.secondary,
              ),
              title: Text(
                'Log out'.tr,
                style: TextStyle(
                    fontSize: _drawerFontSize,
                    color: Theme.of(context).colorScheme.secondary),
              ),
              onTap: () async {
                await AppSharedPrefernces.appSharedPrefernces
                    .deleteData('role');
                await FirebaseAuthApp.firebaseAuthApp.signout();
                Get.offAll(() => const Signin());
              },
            ),
          ],
        ),
      ),
    );
  }
}
