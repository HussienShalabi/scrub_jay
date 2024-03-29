import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scrub_jay/core/app_functions.dart';
import '../../controller/auth_controller.dart';
import '../widgets/HeaderWidget.dart';
import 'ForgotPassword.dart';
import 'SignUpPassenger.dart';
import 'theme_helper.dart';

const double _headerHeight = 200;

class Signin extends StatelessWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthControllerImp controller = Get.put(AuthControllerImp());

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: _headerHeight,
              child: HeaderWidget(_headerHeight, true,
                  Icons.login_rounded), //let's create a common header widget
            ),
            SafeArea(
              child: Container(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                  margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                  // This will be the login form
                  child: Column(
                    children: [
                      Text(
                        'Hello'.tr,
                        style: const TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Sign in into your account'.tr,
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 5),
                      Form(
                          key: controller.formKeySignIn,
                          child: Column(
                            children: [
                              SizedBox(
                                child: Text(
                                  'Sign in as:'.tr,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              GetBuilder<AuthControllerImp>(
                                builder: (controller) => Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                            width: 150,
                                            child: RadioListTile(
                                              contentPadding: EdgeInsets.zero,
                                              title: Text(
                                                'Admin'.tr,
                                              ),
                                              value: 0,
                                              groupValue:
                                                  controller.roleSelected.value,
                                              onChanged: (value) {
                                                controller.updateSelectedValue(
                                                    value!);
                                              },
                                            )),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 150,
                                          child: RadioListTile(
                                            contentPadding: EdgeInsets.zero,
                                            title: Text(
                                              'Passenger'.tr,
                                            ),
                                            value: 2,
                                            groupValue:
                                                controller.roleSelected.value,
                                            onChanged: (value) {
                                              controller
                                                  .updateSelectedValue(value!);
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          width: 130,
                                          child: RadioListTile(
                                            contentPadding: EdgeInsets.zero,
                                            title: Text(
                                              'Driver'.tr,
                                            ),
                                            value: 1,
                                            groupValue:
                                                controller.roleSelected.value,
                                            onChanged: (value) {
                                              controller
                                                  .updateSelectedValue(value!);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                decoration:
                                    ThemeHelper().inputBoxDecorationShaddow(),
                                child: TextFormField(
                                  validator: (value) =>
                                      formValidation(value!, 'value'),
                                  keyboardType: TextInputType.emailAddress,
                                  controller: controller.emailAddress,
                                  decoration: ThemeHelper().textInputDecoration(
                                      "Email address".tr,
                                      "Enter your email address".tr),
                                ),
                              ),
                              const SizedBox(height: 30.0),
                              Container(
                                decoration:
                                    ThemeHelper().inputBoxDecorationShaddow(),
                                child: TextFormField(
                                  obscureText: true,
                                  controller: controller.password,
                                  validator: (value) =>
                                      formValidation(value!, 'password'),
                                  decoration: ThemeHelper().textInputDecoration(
                                      'Password*'.tr, 'Enter your password'.tr),
                                ),
                              ),
                              const SizedBox(height: 15),
                              Container(
                                margin:
                                    const EdgeInsets.fromLTRB(10, 0, 10, 20),
                                alignment: Alignment.topRight,
                                child: GestureDetector(
                                  onTap: () {
                                    Get.to(ForgotPassword());
                                  },
                                  child: Text(
                                    "Forgot your password?".tr,
                                    style: const TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration:
                                    ThemeHelper().buttonBoxDecoration(context),
                                child: GetBuilder<AuthControllerImp>(
                                    init: AuthControllerImp(),
                                    builder: (signInController) {
                                      return SizedBox(
                                        width: 250.w,
                                        child: ElevatedButton(
                                          style: ThemeHelper().buttonStyle(),
                                          onPressed: signInController.isLoading
                                              ? () {}
                                              : () => controller.signIn(),
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                40, 10, 40, 10),
                                            child: signInController.isLoading
                                                ? const Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  )
                                                : Text(
                                                    'Sign In'.tr,
                                                    style: const TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                  ),
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.fromLTRB(10, 20, 10, 20),
                                child: Text.rich(TextSpan(children: [
                                  TextSpan(text: "Don\'t have an account? ".tr),
                                  TextSpan(
                                      text: 'Create account'.tr,
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Get.to(SignUpPassenger());
                                        },
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.yellow.shade800,
                                      )),
                                ])),
                              ),
                            ],
                          )),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
