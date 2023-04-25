import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scrub_jay/controller/signup_controller.dart';
import 'package:scrub_jay/core/app_functions.dart';
import 'package:scrub_jay/view/Driver/DriverMainScreen.dart';
import '../widgets/HeaderWidget.dart';
import 'theme_helper.dart';

class SignUpDriver extends StatelessWidget {
  final SignUpControllerImp signUpcontroler = Get.find<SignUpControllerImp>();

  SignUpDriver({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 150,
              child: HeaderWidget(150, false, Icons.person_add_alt_1_rounded),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(25, 0, 25, 10),
              padding: const EdgeInsets.symmetric(vertical: 50),
              alignment: Alignment.center,
              child: Form(
                key: signUpcontroler.formKey,
                child: Column(
                  children: [
                    Text(
                      'Register as driver'.tr,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                'Please fill in the following information : '
                                    .tr,
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 15.sp),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                          child: TextFormField(
                            validator: (value) =>
                                formValidation(value, 'username'),
                            controller: signUpcontroler.fullname,
                            decoration: ThemeHelper().textInputDecoration(
                                'Full Name'.tr, 'Enter your Full name'.tr),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                          child: TextFormField(
                            controller: signUpcontroler.emailAddress,
                            validator: (value) =>
                                formValidation(value, 'email'),
                            decoration: ThemeHelper().textInputDecoration(
                                "Email address".tr,
                                "Enter your email address".tr),
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Container(
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                          child: TextFormField(
                            controller: signUpcontroler.phoneNumber,
                            validator: (value) =>
                                formValidation(value, 'phone'),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(10),
                            ],
                            decoration: ThemeHelper().textInputDecoration(
                                "Mobile Number".tr,
                                "Enter your mobile number".tr),
                            keyboardType: TextInputType.phone,
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Container(
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                          child: TextFormField(
                            controller: signUpcontroler.password,
                            validator: (value) =>
                                formValidation(value, 'password', 8, 30),
                            obscureText: true,
                            decoration: ThemeHelper().textInputDecoration(
                                "Password*".tr, "Enter your password".tr),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Container(
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                          child: TextFormField(
                            obscureText: true,
                            controller: signUpcontroler.rewritePassword,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "this field is required".tr;
                              }
                              if (signUpcontroler.password.text.trim() !=
                                  signUpcontroler.rewritePassword.text.trim()) {
                                return 'Passwords don\'t match';
                              }
                              return null;
                            },
                            decoration: ThemeHelper().textInputDecoration(
                                "ReEnter Password*".tr,
                                "Enter your password".tr),
                          ),
                        ),
                        const SizedBox(height: 15.0),
                        Container(
                          decoration:
                              ThemeHelper().buttonBoxDecoration(context),
                          child: ElevatedButton(
                            style: ThemeHelper().buttonStyle(),
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(40, 10, 40, 10),
                              child: Text(
                                "Register".tr,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            onPressed: () => signUpcontroler.signup(),
                          ),
                        ),
                      ],
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
