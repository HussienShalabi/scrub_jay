import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scrub_jay/controller/auth_controller.dart';
import 'package:scrub_jay/core/app_functions.dart';
import '../widgets/HeaderWidget.dart';
import 'theme_helper.dart';

class SignUpDriver extends StatelessWidget {
  final AuthControllerImp authController = Get.find<AuthControllerImp>();

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
              padding: const EdgeInsets.symmetric(vertical: 5),
              alignment: Alignment.center,
              child: Form(
                key: authController.signupDriverKey,
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
                            controller: authController.fullName,
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
                            controller: authController.emailAddress,
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
                            controller: authController.phoneNumber,
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
                            controller: authController.password,
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
                            controller: authController.rewritePassword,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "this field is required".tr;
                              }
                              if (authController.password!.text.trim() !=
                                  authController.rewritePassword!.text.trim()) {
                                return 'Passwords don\'t match';
                              }
                              return null;
                            },
                            decoration: ThemeHelper().textInputDecoration(
                                "ReEnter Password*".tr,
                                "Enter your password".tr),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Container(
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                          child: TextFormField(
                            controller: authController.driverIdentityNumber,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "this field is required".tr;
                              }

                              return null;
                            },
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(9),
                            ],
                            decoration: ThemeHelper().textInputDecoration(
                                "Driver identity number".tr,
                                "Enter your driver identity number".tr),
                            keyboardType: TextInputType.phone,
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Container(
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                          child: TextFormField(
                            controller: authController.vehicleNumber,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "this field is required".tr;
                              }

                              return null;
                            },
                            decoration: ThemeHelper().textInputDecoration(
                                "Vehicle number".tr,
                                "Enter your vehicle number".tr),
                            keyboardType: TextInputType.phone,
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Container(
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                          child: TextFormField(
                            controller: authController.licenseNumber,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "this field is required".tr;
                              }
                              return null;
                            },
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(6),
                            ],
                            decoration: ThemeHelper().textInputDecoration(
                                " License number".tr,
                                "Enter your license number".tr),
                            keyboardType: TextInputType.phone,
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        SizedBox(
                          width: 200,
                          child: Container(
                            decoration:
                                ThemeHelper().buttonBoxDecoration(context),
                            child: GetBuilder<AuthControllerImp>(
                              init: AuthControllerImp(),
                              builder: (controller) {
                                return ElevatedButton(
                                  style: ThemeHelper().buttonStyle(),
                                  onPressed: controller.isLoading
                                      ? () {}
                                      : () => controller.driverSignup(),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        40, 10, 40, 10),
                                    child: controller.isLoading
                                        ? const Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        : Text(
                                            "Register".tr,
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                  ),
                                );
                              },
                            ),
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
