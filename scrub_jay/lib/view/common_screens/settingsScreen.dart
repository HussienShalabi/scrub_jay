import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrub_jay/view/common_screens/EditPassword.dart';
import 'package:scrub_jay/view/common_screens/theme_helper.dart';

import '../widgets/HeaderWidget.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Account management".tr,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        elevation: 0.5,
        iconTheme: const IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                Theme.of(context).primaryColor,
                Theme.of(context).colorScheme.secondary,
              ])),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(
              top: 16,
              right: 16,
            ),
            child: Stack(
              children: <Widget>[
                const Icon(Icons.notifications),
                Positioned(
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 12,
                      minHeight: 12,
                    ),
                    child: const Text(
                      '5',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 100,
            child: HeaderWidget(100, false, Icons.house_rounded),
          ),


          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const ListTile(
                  leading: Icon(Icons.person_rounded),
                  minLeadingWidth: 20,
                  title: Text('Edit full name: '),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        obscureText: true,
                        decoration: ThemeHelper().textInputDecoration(
                            'New full name'.tr, 'Enter new full name'.tr),
                      ),
                    ),

                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.save),
                    ),
                  ],
                ),
                const Divider(height: 8),
                const ListTile(
                  leading: Icon(Icons.email),
                  minLeadingWidth: 20,
                  title: Text('Edit email address: '),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        obscureText: true,
                        decoration: ThemeHelper().textInputDecoration(
                            'New email address'.tr, 'Enter New email address'.tr),
                      ),
                    ),

                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.save),
                    ),
                  ],
                ),
                const Divider(height: 8),
                const ListTile(
                  leading: Icon(Icons.phone),
                  minLeadingWidth: 20,
                  title: Text('Edit phone number: '),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        obscureText: true,
                        decoration: ThemeHelper().textInputDecoration(
                            'New phone number'.tr, 'Enter new phone number'.tr),
                      ),
                    ),

                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.save),
                    ),
                  ],
                ),
                const Divider(height: 8),

                const ListTile(
                  minLeadingWidth: 20,
                  leading: Icon(Icons.lock_person_rounded),
                  title: Text('Edit password: '),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        obscureText: true,
                        decoration: ThemeHelper().textInputDecoration(
                            'New password'.tr, 'Enter new password'.tr),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.save),
                    ),
                  ],
                ),
                const Divider(height: 8),
                Container(
                  margin:
                  const EdgeInsets.fromLTRB(10, 20, 10, 20),
                  child: Text.rich(TextSpan(children: [
                    TextSpan(text: "Do you want to deactivate your account? ".tr),
                    TextSpan(
                        text: 'Click here'.tr,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {

                          },
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.yellow.shade700,
                        )),
                  ])),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
