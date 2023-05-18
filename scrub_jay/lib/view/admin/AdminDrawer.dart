import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrub_jay/controller/account_controller.dart';
import 'package:scrub_jay/view/admin/AdminMainScreen.dart';
import 'package:scrub_jay/view/common_screens/settingsScreen.dart';
import '../common_screens/EditPassword.dart';
import '../common_screens/Signin.dart';
import '../common_screens/chooseLang.dart';
// add file constant

class AdminDrawer extends StatelessWidget {
  const AdminDrawer({super.key});

  final double _drawerIconSize = 18;

  final double _drawerFontSize = 17;

  @override
  Widget build(BuildContext context) {
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
              child: Container(
                child: Center(
                  child: Column(
                    children: const [
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        'user name',
                        style: TextStyle(
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
                'Account Management'.tr,
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
                Get.to( EditPassword());
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
              onTap: () {
                Get.off(const Signin());
              },
            ),

          ],
        ),
      ),
    );
  }
}
