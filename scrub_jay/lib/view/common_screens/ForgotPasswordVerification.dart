import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:scrub_jay/view/common_screens/ChangePassword.dart';
import '../widgets/HeaderWidget.dart';
import 'theme_helper.dart';

class ForgotPasswordVerification extends StatefulWidget {
  const ForgotPasswordVerification({Key? key}) : super(key: key);

  @override
  _ForgotPasswordVerificationState createState() =>
      _ForgotPasswordVerificationState();
}

class _ForgotPasswordVerificationState
    extends State<ForgotPasswordVerification> {
  final _formKey = GlobalKey<FormState>();
  bool _pinSuccess = false;

  @override
  Widget build(BuildContext context) {
    double headerHeight = 300;

    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: headerHeight,
                child: HeaderWidget(
                    headerHeight, true, Icons.privacy_tip_outlined),
              ),
              SafeArea(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                'Verification'.tr,
                                style: const TextStyle(
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: Text(
                                'Enter the verification code we just sent to you .'
                                    .tr,
                                style: const TextStyle(
                                    // fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40.0),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            OTPTextField(
                              length: 4,
                              width: 300,
                              fieldWidth: 50,
                              style: const TextStyle(fontSize: 30),
                              textFieldAlignment: MainAxisAlignment.spaceAround,
                              fieldStyle: FieldStyle.box,
                              onCompleted: (pin) {
                                setState(() {
                                  _pinSuccess = true;
                                });
                              },
                            ),
                            const SizedBox(height: 50.0),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: "If you didn't receive a code! ".tr,
                                    style: const TextStyle(
                                      color: Colors.black38,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Resend'.tr,
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return ThemeHelper().alartDialog(
                                                "Successful".tr,
                                                "Verification code resend successful."
                                                    .tr,
                                                context);
                                          },
                                        );
                                      },
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.yellow.shade800,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 40.0),
                            Container(
                              decoration: _pinSuccess
                                  ? ThemeHelper().buttonBoxDecoration(context)
                                  : ThemeHelper().buttonBoxDecoration(context),
                              child: ElevatedButton(
                                  style: ThemeHelper().buttonStyle(),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        40, 10, 40, 10),
                                    child: Text(
                                      "Verify".tr,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    Get.off(const ChangePassword());
                                  }),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
