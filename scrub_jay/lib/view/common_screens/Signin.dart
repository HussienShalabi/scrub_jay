import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrub_jay/view/passenger/ChooseTrip.dart';
import '../widgets/HeaderWidget.dart';
import 'ForgotPassword.dart';
import 'SignUp.dart';
import 'theme_helper.dart';

class Signin extends StatefulWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  double _headerHeight = 250;
  Key _formKey = GlobalKey<FormState>();
  int? x;
  String? _phoneError;
  String? _passError;

  late TextEditingController _phoneTextController;
  late TextEditingController _passTextController;

  @override
  void initState() {
    super.initState();
    _phoneTextController = TextEditingController();
    _passTextController = TextEditingController();
  }

  @override
  void dispose() {
    _phoneTextController.dispose();
    _passTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: _headerHeight,
              child: HeaderWidget(_headerHeight, true,
                  Icons.login_rounded), //let's create a common header widget
            ),
            SafeArea(
              child: Container(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  // This will be the login form
                  child: Column(
                    children: [
                       Text(
                        'Hello'.tr,
                        style: TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                       Text(
                        'Sign in into your account'.tr,
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 30),
                      Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Container(
                                decoration:
                                ThemeHelper().inputBoxDecorationShaddow(),
                                child: TextField(
                                  onChanged: (value) => x = value as int?,
                                  keyboardType: TextInputType.phone,
                                  decoration: ThemeHelper().textInputDecoration(
                                      "Mobile Number".tr,
                                      "Enter your mobile number".tr),
                                ),
                              ),
                              const SizedBox(height: 30.0),
                              Container(
                                decoration:
                                ThemeHelper().inputBoxDecorationShaddow(),
                                child: TextField(
                                  obscureText: true,
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
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                          const ForgotPassword()),
                                    );
                                  },
                                  child:  Text(
                                    "Forgot your password?".tr,
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration:
                                ThemeHelper().buttonBoxDecoration(context),
                                child: ElevatedButton(
                                  style: ThemeHelper().buttonStyle(),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        40, 10, 40, 10),
                                    child: Text(
                                      'Sign In'.tr,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                  onPressed: () {
                                    Get.off(ChooseTrip());
                                    //After successful login we will redirect to profile page.

                                  },
                                ),
                              ),
                              Container(
                                margin:
                                const EdgeInsets.fromLTRB(10, 20, 10, 20),
                                //child: Text('Don\'t have an account? Create'),
                                child: Text.rich(TextSpan(children: [
                                   TextSpan(
                                      text: "Don\'t have an account? ".tr),
                                  TextSpan(
                                      text: 'Create account'.tr,
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SignUp()));
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
