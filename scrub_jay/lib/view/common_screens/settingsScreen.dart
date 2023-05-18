import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:scrub_jay/view/common_screens/EditPassword.dart';
import 'package:scrub_jay/view/common_screens/theme_helper.dart';

import '../../controller/account_controller.dart';
import '../../core/app_functions.dart';
import '../widgets/HeaderWidget.dart';

class SettingsScreen extends StatelessWidget {
  final AccountManagement accountcontroller = Get.find<AccountManagement>();

   SettingsScreen({super.key});

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
            child: Form(
              key: accountcontroller.formKeyEdit,
              child: Column(
                children: [
                   ListTile(
                    leading: Icon(Icons.person_rounded),
                    minLeadingWidth: 20,
                    title: Text('Edit full name: '.tr),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          controller: accountcontroller.fullName,
                          // validator: (value) => formValidation(value, 'username'),
                          decoration: ThemeHelper().textInputDecoration(
                              'New full name'.tr, 'Enter new full name'.tr),
                        ),
                      ),
                      // Container(
                      //   child: GetBuilder<AccountManagement>(
                      //       builder: (controller) {
                      //         return ElevatedButton(
                      //           style: ThemeHelper().buttonStyle(),
                      //           onPressed:controller.isLoading ? () {} :()
                      //           => accountcontroller.changeFullName(),
                      //           // icon: const Icon(Icons.save),
                      //           child: controller.isLoading ? const Center(child: CircularProgressIndicator(),) :
                      //           Text(
                      //             "Save".tr,
                      //             style: const TextStyle(
                      //               fontSize: 20,
                      //               fontWeight: FontWeight.bold,
                      //               color: Colors.white,
                      //             ),
                      //           ),
                      //         );
                      //       }
                      //   ),
                      // ),

                      // IconButton(
                      //   onPressed: () {},
                      //   icon: const Icon(Icons.save),
                      // ),
                    ],
                  ),
                   ListTile(
                    leading: Icon(Icons.email),
                    minLeadingWidth: 20,
                    title: Text('Edit email address: '.tr),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          // validator: (value) => formValidation(value, 'email'),
                          controller: accountcontroller.emailAddress,
                          decoration: ThemeHelper().textInputDecoration(
                              'New email address'.tr,
                              'Enter New email address'.tr),
                        ),
                      ),
                    ],
                  ),
                   ListTile(
                    leading: Icon(Icons.phone),
                    minLeadingWidth: 20,
                    title: Text('Edit phone number: '.tr),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10),
                          ],
                          keyboardType: TextInputType.phone,
                          controller: accountcontroller.phoneNumber,
                          // validator: (value) => formValidation(value, 'phone'),
                          decoration: ThemeHelper().textInputDecoration(
                              'New phone number'.tr, 'Enter new phone number'.tr),
                        ),
                      ),
                    ],
                  ),
                   ListTile(
                    minLeadingWidth: 20,
                    leading: Icon(Icons.lock_person_rounded),
                    title: Text('Edit password: '.tr),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: accountcontroller.password,
                          // validator: (value) => formValidation(value, 'password',8,30),
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          decoration: ThemeHelper().textInputDecoration(
                              'New password'.tr, 'Enter new password'.tr),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    decoration: ThemeHelper().buttonBoxDecoration(context),
                    child: GetBuilder<AccountManagement>(
                      init: AccountManagement(),
                      builder: (accountManagement) {
                        return SizedBox(
                          width: 200,
                          child: ElevatedButton(
                            style: ThemeHelper().buttonStyle(),
                            onPressed: accountManagement.isLoading
                                ? () {}
                                : () => accountcontroller.editData(),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                              child: Text(
                                'Save changes'.tr,
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        );
                      }
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // Container(
                  //   child: ElevatedButton(
                  //     style: ButtonStyle(shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  //       RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(30.0),
                  //       ),
                  //     ),
                  //       minimumSize: MaterialStateProperty.all(const Size(50, 50)),
                  //       backgroundColor: MaterialStateProperty.all(Colors.transparent),
                  //       shadowColor: MaterialStateProperty.all(Colors.transparent),),
                  //     onPressed: () {},
                  //     child: Padding(
                  //       padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                  //       child: Text(
                  //         'Delete account'.tr,
                  //         style: const TextStyle(
                  //             fontSize: 18,
                  //             fontWeight: FontWeight.bold,
                  //             color: Colors.red),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Container(
                    margin:
                    const EdgeInsets.fromLTRB(10, 20, 10, 20),
                    child: Text.rich(TextSpan(children: [
                      TextSpan(text: "To deactivate your account, ".tr),
                      TextSpan(
                          text: 'Press here'.tr,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                             print('hiiiiiiiiiiiii');
                            },
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.yellow.shade800,
                          )),
                    ])),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
