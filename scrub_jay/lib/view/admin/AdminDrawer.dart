import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrub_jay/controller/AdminController.dart';
import 'package:scrub_jay/controller/auth_controller.dart';
import 'package:scrub_jay/view/admin/AdminProfile.dart';
import '../../core/app_shared_preferences.dart';
import '../../core/firebase_app_auth.dart';
import '../common_screens/EditPassword.dart';
import '../common_screens/Signin.dart';
import '../common_screens/chooseLang.dart';
import 'settingsScreen.dart';
// add file constant

class AdminDrawer extends StatelessWidget {
  const AdminDrawer({super.key});

  final double _drawerIconSize = 18;

  final double _drawerFontSize = 17;

  @override
  Widget build(BuildContext context) {
    final AdminControllerImp controllerImp = Get.put(AdminControllerImp());

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
                        controllerImp.currentAdmin == null
                            ? 'username'
                            : controllerImp.currentAdmin!.fullname ??
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
                Get.to(AdminProfile());
              },
            ),
            ListTile(
              leading: Icon(Icons.settings,
                  size: _drawerIconSize,
                  color: Theme.of(context).colorScheme.secondary),
              title: Text(
                'Edit profile'.tr,
                style: TextStyle(
                    fontSize: _drawerFontSize,
                    color: Theme.of(context).colorScheme.secondary),
              ),
              onTap: () {
                Get.to(SettingsScreen());
              },
            ),
            ListTile(
              leading: Icon(Icons.lock_person_rounded,
                  size: _drawerIconSize,
                  color: Theme.of(context).colorScheme.secondary),
              title: Text(
                'Edit password'.tr,
                style: TextStyle(
                    fontSize: _drawerFontSize,
                    color: Theme.of(context).colorScheme.secondary),
              ),
              onTap: () {
                Get.to(EditPassword());
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
                Get.to(() => const chooseLang());
              },
            ),
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
