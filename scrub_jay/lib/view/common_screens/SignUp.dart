import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scrub_jay/controller/signup_controller.dart';
import 'package:scrub_jay/core/app_functions.dart';
import '../widgets/HeaderWidget.dart';
import 'theme_helper.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SignUpState();
  }
}

class _SignUpState extends State<SignUp> with SingleTickerProviderStateMixin {

  late TabController _tabController;
  int _selectedTab = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  final SignUpControllerImp signUpcontroler = Get.find<SignUpControllerImp>();
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
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Form(
                    key: signUpcontroler.formKey,
                    child: Column(
                      children: [
                        Text(
                          'Register as ...'.tr,
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        TabBar(
                            onTap: (value) {
                              setState(() {
                                _selectedTab = value;
                              });
                            },
                            controller: _tabController,
                            indicatorColor: Colors.yellow.shade700,
                            tabs: [
                              Tab(
                                text: 'passenger'.tr,
                              ),
                              Tab(
                                text: 'Driver'.tr,
                              )
                            ]),
                        IndexedStack(
                          index: _selectedTab,
                          children: [
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
                                            color: Colors.black54,
                                            fontSize: 15.sp),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  decoration:
                                      ThemeHelper().inputBoxDecorationShaddow(),
                                  child: TextFormField(
                                    validator: (value) => formValidation(value, 'username'),
                                    controller: signUpcontroler.fullname,
                                    decoration: ThemeHelper()
                                        .textInputDecoration('Full Name'.tr,
                                            'Enter your Full name'.tr),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  decoration:
                                      ThemeHelper().inputBoxDecorationShaddow(),
                                  child: TextFormField(
                                    decoration: ThemeHelper()
                                        .textInputDecoration("Mobile Number".tr,
                                            "Enter your mobile number".tr),
                                    keyboardType: TextInputType.phone,
                                    controller: signUpcontroler.phoneNumber,
                                    validator:(value) => formValidation(value, 'phone'),
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(10),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20.0),
                                Container(
                                  decoration:
                                      ThemeHelper().inputBoxDecorationShaddow(),
                                  child: TextFormField(
                                    obscureText: true,
                                    decoration: ThemeHelper()
                                        .textInputDecoration("Password*".tr,
                                            "Enter your password".tr),
                                    controller: signUpcontroler.password  ,
                                    validator: (value) => formValidation(value, 'password', 8,30),
                                  ),
                                ),
                                const SizedBox(height: 20.0),
                                Container(
                                  decoration:
                                      ThemeHelper().inputBoxDecorationShaddow(),
                                  child: TextFormField(
                                    obscureText: true,
                                    controller: signUpcontroler.rewritePassword,
                                    decoration: ThemeHelper()
                                        .textInputDecoration(
                                            "ReEnter Password*".tr,
                                            "Enter your password".tr),
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        return "this field is required".tr;
                                      }
                                      if (signUpcontroler.password.text.trim() != signUpcontroler.rewritePassword.text.trim()) {
                                        return 'Passwords don\'t match';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                const SizedBox(height: 15.0),
                                Container(
                                  decoration: ThemeHelper()
                                      .buttonBoxDecoration(context),
                                  child: ElevatedButton(
                                    style: ThemeHelper().buttonStyle(),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          40, 10, 40, 10),
                                      child: Text(
                                        "Register".tr,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    onPressed: () =>signUpcontroler.signup(),
                                  ),
                                ),
                              ],
                            ),
                            if(_selectedTab == 1)
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
                                            color: Colors.black54,
                                            fontSize: 15.sp),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  decoration:
                                  ThemeHelper().inputBoxDecorationShaddow(),
                                  child: TextFormField(
                                    decoration: ThemeHelper()
                                        .textInputDecoration('Full Name'.tr,
                                        'Enter your Full name'.tr),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  decoration:
                                  ThemeHelper().inputBoxDecorationShaddow(),
                                  child: TextFormField(
                                    decoration: ThemeHelper()
                                        .textInputDecoration("Mobile Number".tr,
                                        "Enter your mobile number".tr),
                                    keyboardType: TextInputType.phone,
                                    validator: (val) {
                                      if (!(val!.isEmpty) &&
                                          !RegExp(r"^(\d+)*$").hasMatch(val)) {
                                        return "Enter a valid phone number".tr;
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                const SizedBox(height: 20.0),
                                Container(
                                  decoration:
                                  ThemeHelper().inputBoxDecorationShaddow(),
                                  child: TextFormField(
                                    obscureText: true,
                                    decoration: ThemeHelper()
                                        .textInputDecoration("Password*".tr,
                                        "Enter your password".tr),
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        return "Please enter your password".tr;
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                const SizedBox(height: 20.0),
                                Container(
                                  decoration:
                                  ThemeHelper().inputBoxDecorationShaddow(),
                                  child: TextFormField(
                                    obscureText: true,
                                    decoration: ThemeHelper()
                                        .textInputDecoration(
                                        "ReEnter Password*".tr,
                                        "Enter your password".tr),
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        return "Please enter your password".tr;
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                const SizedBox(height: 15.0),
                                Container(
                                  decoration: ThemeHelper()
                                      .buttonBoxDecoration(context),
                                  child: ElevatedButton(
                                    style: ThemeHelper().buttonStyle(),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          40, 10, 40, 10),
                                      child: Text(
                                        "Register".tr,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    onPressed: () {},
                                  ),
                                ),
                              ],
                            ),
                            //here
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
