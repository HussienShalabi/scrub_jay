import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:scrub_jay/controller/AdminController.dart';
import 'package:scrub_jay/view/common_screens/theme_helper.dart';

import '../../controller/account_controller.dart';
import '../widgets/HeaderWidget.dart';

class SettingsScreen extends StatelessWidget {
  final AccountManagement accountcontroller = Get.find<AccountManagement>();
  final AdminControllerImp passengerControllerImp =
      Get.put(AdminControllerImp());

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
              key: passengerControllerImp.formKeyEdit,
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.person_rounded),
                    minLeadingWidth: 20,
                    title: Text('Edit full name: '.tr),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          controller: passengerControllerImp.fullName,
                          // validator: (value) => formValidation(value, 'username'),
                          decoration: ThemeHelper().textInputDecoration(
                              'New full name'.tr, 'Enter new full name'.tr),
                        ),
                      ),
                    ],
                  ),
                  ListTile(
                    leading: const Icon(Icons.email),
                    minLeadingWidth: 20,
                    title: Text('Edit email address: '.tr),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          // validator: (value) => formValidation(value, 'email'),
                          controller: passengerControllerImp.emailAddress,
                          decoration: ThemeHelper().textInputDecoration(
                              'New email address'.tr,
                              'Enter New email address'.tr),
                        ),
                      ),
                    ],
                  ),
                  ListTile(
                    leading: const Icon(Icons.phone),
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
                          controller: passengerControllerImp.phoneNumber,
                          // validator: (value) => formValidation(value, 'phone'),
                          decoration: ThemeHelper().textInputDecoration(
                              'New phone number'.tr,
                              'Enter new phone number'.tr),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  Container(
                    decoration: ThemeHelper().buttonBoxDecoration(context),
                    child: GetBuilder<AdminControllerImp>(
                        init: AdminControllerImp(),
                        builder: (passengerController) {
                          return SizedBox(
                            width: 200,
                            child: ElevatedButton(
                              style: ThemeHelper().buttonStyle(),
                              onPressed: passengerController.isLoading
                                  ? () {}
                                  : () => passengerController.editData(),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
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
                        }),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                    child: Text.rich(TextSpan(children: [
                      TextSpan(text: "To deactivate your account, ".tr),
                      TextSpan(
                          text: 'Press here'.tr,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              accountcontroller.deleteAccount();
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
