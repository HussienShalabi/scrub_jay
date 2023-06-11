import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrub_jay/controller/passenger_controller.dart';
import '../common_screens/theme_helper.dart';
import '../widgets/HeaderWidget.dart';

class EditPassword extends StatelessWidget {
  final PassengerControllerImp controllerImp =
      Get.put(PassengerControllerImp());

  EditPassword({Key? key}) : super(key: key);

  final double _headerHeight = 250;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Edit password".tr,
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
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: _headerHeight,
              child:
                  HeaderWidget(_headerHeight, true, Icons.lock_person_rounded),
            ),
            SafeArea(
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                // This will be the login form
                child: Column(
                  children: [
                    Text(
                      'Change your password'.tr,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 30),
                    Form(
                      key: controllerImp.updatePasswordFormKey,
                      child: Column(
                        children: [
                          const SizedBox(height: 15),
                          Container(
                            decoration:
                                ThemeHelper().inputBoxDecorationShaddow(),
                            child: TextFormField(
                              validator: (value) {
                                if (value == '') {
                                  return 'this field is required';
                                }
                                return null;
                              },
                              controller: controllerImp.oldPasswrod,
                              obscureText: true,
                              decoration: ThemeHelper().textInputDecoration(
                                  'Old password*'.tr,
                                  'Enter your old password'.tr),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Container(
                            decoration:
                                ThemeHelper().inputBoxDecorationShaddow(),
                            child: TextFormField(
                              obscureText: true,
                              validator: (value) {
                                if (value == '') {
                                  return 'this field is required';
                                }
                                return null;
                              },
                              controller: controllerImp.password,
                              decoration: ThemeHelper().textInputDecoration(
                                  'New password*'.tr,
                                  'Enter your new password'.tr),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Container(
                            decoration:
                                ThemeHelper().inputBoxDecorationShaddow(),
                            child: TextFormField(
                              validator: (value) {
                                if (value == '') {
                                  return 'this field is required';
                                }

                                if (controllerImp.password.text !=
                                    controllerImp.rewritePassword.text) {
                                  return 'Passwords not match';
                                }
                                return null;
                              },
                              controller: controllerImp.rewritePassword,
                              obscureText: true,
                              decoration: ThemeHelper().textInputDecoration(
                                  'ReEnter new password*'.tr,
                                  'ReEnter your new password'.tr),
                            ),
                          ),
                          const SizedBox(height: 30),
                          GetBuilder<PassengerControllerImp>(
                              init: PassengerControllerImp(),
                              builder: (controller) {
                                return Container(
                                  decoration: ThemeHelper()
                                      .buttonBoxDecoration(context),
                                  child: ElevatedButton(
                                    onPressed: controller.isLoading
                                        ? () {}
                                        : () => controller.updatePassword(),
                                    style: ThemeHelper().buttonStyle(),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          40, 10, 40, 10),
                                      child: controller.isLoading
                                          ? const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            )
                                          : Text(
                                              'Change password'.tr,
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                    ),
                                  ),
                                );
                              }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
