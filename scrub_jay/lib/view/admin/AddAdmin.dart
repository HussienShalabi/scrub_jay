import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:scrub_jay/controller/AdminController.dart';
import '../../controller/auth_controller.dart';
import '../../core/app_functions.dart';
import '../common_screens/theme_helper.dart';
import '../widgets/headerWidget.dart';
import 'AdminDrawer.dart';

class AddAdmin extends StatelessWidget {
  final AdminControllerImp adminController = Get.find<AdminControllerImp>();

  AddAdmin({super.key});
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
            const SizedBox(
              height: 100,
              child: HeaderWidget(100, false, Icons.person_add_alt_1_rounded),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(25, 0, 25, 10),
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Form(
                    key: adminController.createAdminKey,
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
                            style: const TextStyle(
                                color: Colors.black54, fontSize: 15),
                          ),
                        ),
                        Container(
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                          child: TextFormField(
                            validator: (value) =>
                                formValidation(value, 'username'),
                            controller: adminController.fullName,
                            decoration: ThemeHelper().textInputDecoration(
                                'Full Name'.tr, 'Enter full name'.tr),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                          child: TextFormField(
                            controller: adminController.emailAddress,
                            validator: (value) =>
                                formValidation(value, 'email'),
                            decoration: ThemeHelper().textInputDecoration(
                                'Email address'.tr,
                                'Enter email address'.tr),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Container(
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                          child: TextFormField(
                            controller: adminController.phoneNumber,
                            validator: (value) =>
                                formValidation(value, 'phone'),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(10),
                            ],
                            decoration: ThemeHelper().textInputDecoration(
                                "Mobile Number".tr,
                                "Enter mobile number".tr),
                            keyboardType: TextInputType.phone,
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Container(
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                          child: TextFormField(
                            controller: adminController.password,
                            validator: (value) =>
                                formValidation(value, 'password', 8, 30),
                            obscureText: true,
                            decoration: ThemeHelper().textInputDecoration(
                                "Password*".tr, "Enter password".tr),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Container(
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                          child: TextFormField(
                            obscureText: true,
                            controller: adminController.rewritePassword,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "this field is required".tr;
                              }
                              if (adminController.password.text.trim() !=
                                  adminController.rewritePassword.text.trim()) {
                                return 'Passwords don\'t match'.tr;
                              }
                              return null;
                            },
                            decoration: ThemeHelper().textInputDecoration(
                                "ReEnter Password*".tr,
                                "Enter password".tr),
                          ),
                        ),
                        const SizedBox(height: 30.0),
                        SizedBox(
                          width: 200,
                          child: Container(
                            decoration:
                                ThemeHelper().buttonBoxDecoration(context),
                            child: GetBuilder<AdminControllerImp>(
                              init: AdminControllerImp(),
                              builder: (controller) {
                                return controller.isLoading
                                    ? const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : ElevatedButton(
                                        style: ThemeHelper().buttonStyle(),
                                        onPressed: controller.isLoading
                                            ? () {}
                                            : () => controller.adminSignup(),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              40, 10, 40, 10),
                                          child: Text(
                                            "Add".tr.toUpperCase(),
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
