import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrub_jay/view/driver/DriverMap.dart';
import '../../controller/driver_controller.dart';
import '../common_screens/EditPassword.dart';
import '../common_screens/Signin.dart';
import '../common_screens/chooseLang.dart';
import '../common_screens/settingsScreen.dart';
import 'DriverMainScreen.dart';

class DriverDrawer extends StatefulWidget {
  const DriverDrawer({super.key});

  @override
  State<DriverDrawer> createState() => _DriverDrawerState();
}

class _DriverDrawerState extends State<DriverDrawer> {
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
              leading: Icon(Icons.drive_eta_rounded,
                  size: _drawerIconSize,
                  color: Theme.of(context).colorScheme.secondary),
              title: Text(
                'Driver main page'.tr,
                style: TextStyle(
                    fontSize: _drawerFontSize,
                    color: Theme.of(context).colorScheme.secondary),
              ),
              onTap: () {
                Get.to(const DriverMainScreen());
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
                Get.to(const chooseLang());
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
                Get.find<DriverControllerImp>().driverSignout();
              },
            ),
          ],
        ),
      ),
    );
  }
}
