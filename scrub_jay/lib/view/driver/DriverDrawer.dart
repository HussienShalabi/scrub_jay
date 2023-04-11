import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common_screens/EditPassword.dart';
import '../common_screens/Signin.dart';
import '../common_screens/chooseLang.dart';
import 'DriverMainScreen.dart';




class DriverDrawer extends StatefulWidget {
  const DriverDrawer({super.key});

  @override
  State<DriverDrawer> createState() => _DriverDrawerState();
}

class _DriverDrawerState extends State<DriverDrawer> {
  double _drawerIconSize = 18;

  double _drawerFontSize = 17;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [
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
                  stops: [0.0, 1.0],
                  colors: [
                    Theme.of(context).primaryColor,
                    Theme.of(context).colorScheme.secondary,
                  ],
                ),
              ),
              child: Container(
                child: Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 40,
                      ),
                      SizedBox(
                        height: 10,
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
              // accountName: Text('blah blah'),
              // child: Container(
              //   alignment: Alignment.bottomLeft,
              //   child:
              //   const Text(
              //     "Settings",
              //     style: TextStyle(
              //         fontSize: 25,
              //         color: Colors.white,
              //         fontWeight: FontWeight.bold),
              //   ),
              //
              // ),
            ),
            ListTile(
              leading: Icon(Icons.person,
                  size: _drawerIconSize,
                  color: Theme.of(context).colorScheme.secondary),
              title: Text(
                'Profile Page'.tr,
                style: TextStyle(
                    fontSize: _drawerFontSize,
                    color: Theme.of(context).colorScheme.secondary),
              ),
              onTap: () {

              },
            ),



            Divider(
              color: Theme.of(context).primaryColor,
              height: 1,
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
                Get.to(DriverMainScreen());
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
                Get.off(Signin());
              },
            ),

          ],
        ),
      ),
    );
  }
}
