import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../widgets/HeaderWidget.dart';
import 'theme_helper.dart';

class SignUp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignUpState();
  }
}

class _SignUpState extends State<SignUp>
    with SingleTickerProviderStateMixin {
  // final _formKey = GlobalKey<FormState>();
  bool checkedValue = false;
  bool checkboxValue = false;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 150,
              child: HeaderWidget(150, false, Icons.person_add_alt_1_rounded),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(25, 0, 25, 10),
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Form(
                    // key: _formKey,
                    child: Column(
                      children: [

                         Text(
                          'Register as ...'.tr,
                          style: TextStyle(
                            fontSize: 20,),
                        ),
                        TabBar(
                          onTap: (value) {
                            setState(() {
                              _selectedTab = value;
                            });
                          },
                            controller: _tabController,
                            indicatorColor: Colors.yellow.shade700,
                            tabs:  [
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
                                // SizedBox(
                                //   height: 20,
                                // ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(10),
                                      child:  Text(
                                        'Please fill in the following information : '.tr,
                                        style: TextStyle(color: Colors.black54, fontSize: 15.sp),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  child: TextFormField(
                                    decoration: ThemeHelper().textInputDecoration(
                                        'First Name'.tr, 'Enter your first name'.tr),
                                  ),
                                  decoration: ThemeHelper().inputBoxDecorationShaddow(),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  child: TextFormField(
                                    decoration: ThemeHelper().textInputDecoration(
                                        'Last Name'.tr, 'Enter your last name'.tr),
                                  ),
                                  decoration: ThemeHelper().inputBoxDecorationShaddow(),
                                ),

                                SizedBox(height: 20.0),
                                Container(
                                  child: TextFormField(
                                    decoration: ThemeHelper().textInputDecoration(
                                        "Mobile Number".tr, "Enter your mobile number".tr),
                                    keyboardType: TextInputType.phone,
                                    validator: (val) {
                                      if (!(val!.isEmpty) &&
                                          !RegExp(r"^(\d+)*$").hasMatch(val)) {
                                        return "Enter a valid phone number".tr;
                                      }
                                      return null;
                                    },
                                  ),
                                  decoration: ThemeHelper().inputBoxDecorationShaddow(),
                                ),
                                SizedBox(height: 20.0),
                                Container(
                                  child: TextFormField(
                                    obscureText: true,
                                    decoration: ThemeHelper().textInputDecoration(
                                        "Password*".tr, "Enter your password".tr),
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        return "Please enter your password".tr;
                                      }
                                      return null;
                                    },
                                  ),
                                  decoration: ThemeHelper().inputBoxDecorationShaddow(),
                                ),
                                SizedBox(height: 20.0),
                                Container(
                                  child: TextFormField(
                                    obscureText: true,
                                    decoration: ThemeHelper().textInputDecoration(
                                        "ReEnter Password*".tr, "Enter your password".tr),
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        return "Please enter your password".tr;
                                      }
                                      return null;
                                    },
                                  ),
                                  decoration: ThemeHelper().inputBoxDecorationShaddow(),
                                ),
                                SizedBox(height: 15.0),
                                FormField<bool>(
                                  builder: (state) {
                                    return Column(
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Checkbox(
                                                value: checkboxValue,
                                                onChanged: (value) {
                                                  setState(() {
                                                    checkboxValue = value!;
                                                    state.didChange(value);
                                                  });
                                                }),
                                            Text(
                                              "I accept all terms and conditions.".tr,
                                              style: TextStyle(color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            state.errorText ?? '',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              color:
                                              Theme.of(context).colorScheme.error,
                                              fontSize: 12,
                                            ),
                                          ),
                                        )
                                      ],
                                    );
                                  },
                                  validator: (value) {
                                    if (!checkboxValue) {
                                      return 'You need to accept terms and conditions'.tr;
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                SizedBox(height: 20.0),
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
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    onPressed: () {


                                    },
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  child: TextFormField(
                                    decoration: ThemeHelper().textInputDecoration(
                                        'First Name'.tr, 'Enter your first name'.tr),
                                  ),
                                  decoration: ThemeHelper().inputBoxDecorationShaddow(),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  child: TextFormField(
                                    decoration: ThemeHelper().textInputDecoration(
                                        'Last Name'.tr, 'Enter your last name'.tr),
                                  ),
                                  decoration: ThemeHelper().inputBoxDecorationShaddow(),
                                ),

                                SizedBox(height: 20.0),
                                Container(
                                  child: TextFormField(
                                    decoration: ThemeHelper().textInputDecoration(
                                        "Mobile Number".tr, "Enter your mobile number".tr),
                                    keyboardType: TextInputType.phone,
                                    validator: (val) {
                                      if (!(val!.isEmpty) &&
                                          !RegExp(r"^(\d+)*$").hasMatch(val)) {
                                        return "Enter a valid phone number".tr;
                                      }
                                      return null;
                                    },
                                  ),
                                  decoration: ThemeHelper().inputBoxDecorationShaddow(),
                                ),
                                SizedBox(height: 20.0),
                                Container(
                                  child: TextFormField(
                                    obscureText: true,
                                    decoration: ThemeHelper().textInputDecoration(
                                        "Password*".tr, "Enter your password".tr),
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        return "Please enter your password".tr;
                                      }
                                      return null;
                                    },
                                  ),
                                  decoration: ThemeHelper().inputBoxDecorationShaddow(),
                                ),
                                SizedBox(height: 20.0),
                                Container(
                                  child: TextFormField(
                                    obscureText: true,
                                    decoration: ThemeHelper().textInputDecoration(
                                        "ReEnter Password*".tr, "Enter your password".tr),
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        return "Please enter your password".tr;
                                      }
                                      return null;
                                    },
                                  ),
                                  decoration: ThemeHelper().inputBoxDecorationShaddow(),
                                ),
                                SizedBox(height: 15),

                                FormField<bool>(
                                  builder: (state) {
                                    return Column(
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Checkbox(
                                                value: checkboxValue,
                                                onChanged: (value) {
                                                  setState(() {
                                                    checkboxValue = value!;
                                                    state.didChange(value);
                                                  });
                                                }),
                                            Text(
                                              "I accept all terms and conditions.".tr,
                                              style: TextStyle(color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            state.errorText ?? '',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              color:
                                              Theme.of(context).colorScheme.error,
                                              fontSize: 12,
                                            ),
                                          ),
                                        )
                                      ],
                                    );
                                  },
                                  validator: (value) {
                                    if (!checkboxValue) {
                                      return 'You need to accept terms and conditions'.tr;
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                SizedBox(height: 20.0),
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
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    onPressed: () {


                                    },
                                  ),
                                ),
                              ],
                            ),
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
