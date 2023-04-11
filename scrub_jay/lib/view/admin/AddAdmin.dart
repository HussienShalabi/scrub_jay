
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../common_screens/theme_helper.dart';
import '../widgets/HeaderWidget.dart';
import 'AdminDrawer.dart';
import 'AdminMainScreen.dart';


class AddAdmin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddAdminState();
  }
}

class _AddAdminState extends State<AddAdmin>
    with SingleTickerProviderStateMixin {
  // final _formKey = GlobalKey<FormState>();
  bool checkedValue = false;
  bool checkboxValue = false;
  late TabController _tabController;
  int _selectedTab = 0;

  // Default Radio Button Selected Item When App Starts.
  String radioButtonItem = 'No';

  // Group Value for Radio Button.
  int id = 2;

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
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "New Admin".tr,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
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
      drawer: const AdminDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 100,
              child: const HeaderWidget(100, false, Icons.person_add_alt_1_rounded),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(25, 0, 25, 10),
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Form(
                    // key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: Text(
                            'Please fill in the following information : '.tr,
                            style:
                                const TextStyle(color: Colors.black54, fontSize: 15),
                          ),
                        ),

                        Container(
                          child: TextFormField(
                            decoration: ThemeHelper().textInputDecoration(
                                'First Name'.tr, 'Enter your first name'.tr),
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: TextFormField(
                            decoration: ThemeHelper().textInputDecoration(
                                'Last Name'.tr, 'Enter your last name'.tr),
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),

                        const SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            decoration: ThemeHelper().textInputDecoration(
                                "Mobile Number".tr,
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
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        const SizedBox(height: 20.0),
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
                        const SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            obscureText: true,
                            decoration: ThemeHelper().textInputDecoration(
                                "ReEnter Password*".tr,
                                "Enter your password".tr),
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Please enter your password".tr;
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        // SizedBox(height: 15.0),
                        // FormField<bool>(
                        //   builder: (state) {
                        //     return Column(
                        //       children: <Widget>[
                        //         Row(
                        //           children: <Widget>[
                        //             Checkbox(
                        //                 value: checkboxValue,
                        //                 onChanged: (value) {
                        //                   setState(() {
                        //                     checkboxValue = value!;
                        //                     state.didChange(value);
                        //                   });
                        //                 }),
                        //             Text(
                        //               "I accept all terms and conditions.",
                        //               style: TextStyle(color: Colors.grey),
                        //             ),
                        //           ],
                        //         ),
                        //         Container(
                        //           alignment: Alignment.centerLeft,
                        //           child: Text(
                        //             state.errorText ?? '',
                        //             textAlign: TextAlign.left,
                        //             style: TextStyle(
                        //               color:
                        //               Theme.of(context).colorScheme.error,
                        //               fontSize: 12,
                        //             ),
                        //           ),
                        //         )
                        //       ],
                        //     );
                        //   },
                        //   validator: (value) {
                        //     if (!checkboxValue) {
                        //       return 'You need to accept terms and conditions';
                        //     } else {
                        //       return null;
                        //     }
                        //   },
                        // ),
                        const SizedBox(height: 30.0),
                        Container(
                          decoration:
                              ThemeHelper().buttonBoxDecoration(context),
                          child: ElevatedButton(
                            style: ThemeHelper().buttonStyle(),
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(40, 10, 40, 10),
                              child: Text(
                                "Add".tr.toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            onPressed: () {
                              // if (_formKey.currentState!.validate()) {
                              Get.to(const AdminMainScreen());
                            },
                          ),
                        ),
                        // TabBar(
                        //     onTap: (value) {
                        //       setState(() {
                        //         _selectedTab = value;
                        //       });
                        //     },
                        //     controller: _tabController,
                        //     indicatorColor: Colors.yellow.shade700,
                        //     tabs: const [
                        //       Tab(
                        //         text: 'passenger',
                        //       ),
                        //       Tab(
                        //         text: 'Driver',
                        //       )
                        //     ]),
                        // IndexedStack(
                        //   index: _selectedTab,
                        //   children: [
                        //     Column(
                        //       children: [
                        //         // SizedBox(
                        //         //   height: 20,
                        //         // ),
                        //         Row(
                        //           children: [
                        //             Padding(
                        //               padding: const EdgeInsets.all(20),
                        //               child: const Text(
                        //                 'Enter the required informations below: ',
                        //                 style: TextStyle(color: Colors.black54, fontSize: 15),
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //         Container(
                        //           child: TextFormField(
                        //             decoration: ThemeHelper().textInputDecoration(
                        //                 'First Name', 'Enter your first name'),
                        //           ),
                        //           decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        //         ),
                        //         SizedBox(
                        //           height: 20,
                        //         ),
                        //         Container(
                        //           child: TextFormField(
                        //             decoration: ThemeHelper().textInputDecoration(
                        //                 'Last Name', 'Enter your last name'),
                        //           ),
                        //           decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        //         ),
                        //
                        //         SizedBox(height: 20.0),
                        //         Container(
                        //           child: TextFormField(
                        //             decoration: ThemeHelper().textInputDecoration(
                        //                 "Mobile Number", "Enter your mobile number"),
                        //             keyboardType: TextInputType.phone,
                        //             validator: (val) {
                        //               if (!(val!.isEmpty) &&
                        //                   !RegExp(r"^(\d+)*$").hasMatch(val)) {
                        //                 return "Enter a valid phone number";
                        //               }
                        //               return null;
                        //             },
                        //           ),
                        //           decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        //         ),
                        //         SizedBox(height: 20.0),
                        //         Container(
                        //           child: TextFormField(
                        //             obscureText: true,
                        //             decoration: ThemeHelper().textInputDecoration(
                        //                 "Password*", "Enter your password"),
                        //             validator: (val) {
                        //               if (val!.isEmpty) {
                        //                 return "Please enter your password";
                        //               }
                        //               return null;
                        //             },
                        //           ),
                        //           decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        //         ),
                        //         SizedBox(height: 20.0),
                        //         Container(
                        //           child: TextFormField(
                        //             obscureText: true,
                        //             decoration: ThemeHelper().textInputDecoration(
                        //                 "ReEnter Password*", "Enter your password"),
                        //             validator: (val) {
                        //               if (val!.isEmpty) {
                        //                 return "Please enter your password";
                        //               }
                        //               return null;
                        //             },
                        //           ),
                        //           decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        //         ),
                        //         SizedBox(height: 15.0),
                        //         FormField<bool>(
                        //           builder: (state) {
                        //             return Column(
                        //               children: <Widget>[
                        //                 Row(
                        //                   children: <Widget>[
                        //                     Checkbox(
                        //                         value: checkboxValue,
                        //                         onChanged: (value) {
                        //                           setState(() {
                        //                             checkboxValue = value!;
                        //                             state.didChange(value);
                        //                           });
                        //                         }),
                        //                     Text(
                        //                       "I accept all terms and conditions.",
                        //                       style: TextStyle(color: Colors.grey),
                        //                     ),
                        //                   ],
                        //                 ),
                        //                 Container(
                        //                   alignment: Alignment.centerLeft,
                        //                   child: Text(
                        //                     state.errorText ?? '',
                        //                     textAlign: TextAlign.left,
                        //                     style: TextStyle(
                        //                       color:
                        //                       Theme.of(context).colorScheme.error,
                        //                       fontSize: 12,
                        //                     ),
                        //                   ),
                        //                 )
                        //               ],
                        //             );
                        //           },
                        //           validator: (value) {
                        //             if (!checkboxValue) {
                        //               return 'You need to accept terms and conditions';
                        //             } else {
                        //               return null;
                        //             }
                        //           },
                        //         ),
                        //         SizedBox(height: 20.0),
                        //         Container(
                        //           decoration:
                        //           ThemeHelper().buttonBoxDecoration(context),
                        //           child: ElevatedButton(
                        //             style: ThemeHelper().buttonStyle(),
                        //             child: Padding(
                        //               padding:
                        //               const EdgeInsets.fromLTRB(40, 10, 40, 10),
                        //               child: Text(
                        //                 "Register".toUpperCase(),
                        //                 style: TextStyle(
                        //                   fontSize: 20,
                        //                   fontWeight: FontWeight.bold,
                        //                   color: Colors.white,
                        //                 ),
                        //               ),
                        //             ),
                        //             onPressed: () {
                        //               // if (_formKey.currentState!.validate()) {
                        //               Navigator.of(context).pushAndRemoveUntil(
                        //                   MaterialPageRoute(
                        //                       builder: (context) => ProfilePage()),
                        //                       (Route<dynamic> route) => false);
                        //             },
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //     Column(
                        //       children: [
                        //         SizedBox(
                        //           height: 20,
                        //         ),
                        //         Container(
                        //           child: TextFormField(
                        //             decoration: ThemeHelper().textInputDecoration(
                        //                 'First Name', 'Enter your first name'),
                        //           ),
                        //           decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        //         ),
                        //         SizedBox(
                        //           height: 20,
                        //         ),
                        //         Container(
                        //           child: TextFormField(
                        //             decoration: ThemeHelper().textInputDecoration(
                        //                 'Last Name', 'Enter your last name'),
                        //           ),
                        //           decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        //         ),
                        //
                        //         SizedBox(height: 20.0),
                        //         Container(
                        //           child: TextFormField(
                        //             decoration: ThemeHelper().textInputDecoration(
                        //                 "Mobile Number", "Enter your mobile number"),
                        //             keyboardType: TextInputType.phone,
                        //             validator: (val) {
                        //               if (!(val!.isEmpty) &&
                        //                   !RegExp(r"^(\d+)*$").hasMatch(val)) {
                        //                 return "Enter a valid phone number";
                        //               }
                        //               return null;
                        //             },
                        //           ),
                        //           decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        //         ),
                        //         SizedBox(height: 20.0),
                        //         Container(
                        //           child: TextFormField(
                        //             obscureText: true,
                        //             decoration: ThemeHelper().textInputDecoration(
                        //                 "Password*", "Enter your password"),
                        //             validator: (val) {
                        //               if (val!.isEmpty) {
                        //                 return "Please enter your password";
                        //               }
                        //               return null;
                        //             },
                        //           ),
                        //           decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        //         ),
                        //         SizedBox(height: 20.0),
                        //         Container(
                        //           child: TextFormField(
                        //             obscureText: true,
                        //             decoration: ThemeHelper().textInputDecoration(
                        //                 "ReEnter Password*", "Enter your password"),
                        //             validator: (val) {
                        //               if (val!.isEmpty) {
                        //                 return "Please enter your password";
                        //               }
                        //               return null;
                        //             },
                        //           ),
                        //           decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        //         ),
                        //         SizedBox(height: 15),
                        //
                        //         FormField<bool>(
                        //           builder: (state) {
                        //             return Column(
                        //               children: <Widget>[
                        //                 Row(
                        //                   children: <Widget>[
                        //                     Checkbox(
                        //                         value: checkboxValue,
                        //                         onChanged: (value) {
                        //                           setState(() {
                        //                             checkboxValue = value!;
                        //                             state.didChange(value);
                        //                           });
                        //                         }),
                        //                     Text(
                        //                       "I accept all terms and conditions.",
                        //                       style: TextStyle(color: Colors.grey),
                        //                     ),
                        //                   ],
                        //                 ),
                        //                 Container(
                        //                   alignment: Alignment.centerLeft,
                        //                   child: Text(
                        //                     state.errorText ?? '',
                        //                     textAlign: TextAlign.left,
                        //                     style: TextStyle(
                        //                       color:
                        //                       Theme.of(context).colorScheme.error,
                        //                       fontSize: 12,
                        //                     ),
                        //                   ),
                        //                 )
                        //               ],
                        //             );
                        //           },
                        //           validator: (value) {
                        //             if (!checkboxValue) {
                        //               return 'You need to accept terms and conditions';
                        //             } else {
                        //               return null;
                        //             }
                        //           },
                        //         ),
                        //         SizedBox(height: 20.0),
                        //         Container(
                        //           decoration:
                        //           ThemeHelper().buttonBoxDecoration(context),
                        //           child: ElevatedButton(
                        //             style: ThemeHelper().buttonStyle(),
                        //             child: Padding(
                        //               padding:
                        //               const EdgeInsets.fromLTRB(40, 10, 40, 10),
                        //               child: Text(
                        //                 "Register".toUpperCase(),
                        //                 style: TextStyle(
                        //                   fontSize: 20,
                        //                   fontWeight: FontWeight.bold,
                        //                   color: Colors.white,
                        //                 ),
                        //               ),
                        //             ),
                        //             onPressed: () {
                        //               // if (_formKey.currentState!.validate()) {
                        //               Navigator.of(context).pushAndRemoveUntil(
                        //                   MaterialPageRoute(
                        //                       builder: (context) => ProfilePage()),
                        //                       (Route<dynamic> route) => false);
                        //             },
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ],
                        // ),
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
