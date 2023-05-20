import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scrub_jay/controller/AdminController.dart';
import 'package:scrub_jay/view/admin/MakeTurn.dart';
import '../common_screens/theme_helper.dart';
import '../widgets/HeaderWidget.dart';
import 'AddAdmin.dart';
import 'AdminDrawer.dart';
import 'ConfirmDriver.dart';
import 'DeleteDriver.dart';
import 'DriversList.dart';
import '../Driver/MakeATrip.dart';

class AdminMainScreen extends StatelessWidget {
  const AdminMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Admin main page".tr,
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
        drawer: GetBuilder<AdminControllerImp>(
            init: AdminControllerImp(),
            builder: (controller) {
              if (controller.isGetInformation) {
                return const SizedBox();
              }
              return const AdminDrawer();
            }),
        body: GetBuilder<AdminControllerImp>(
            init: AdminControllerImp(),
            builder: (controller) {
              if (controller.isGetInformation) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return SingleChildScrollView(
                child: Stack(
                  children: [
                    const SizedBox(
                      height: 100,
                      child: HeaderWidget(100, false, Icons.house_rounded),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.fromLTRB(25, 120, 25, 10),
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          GridView(
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                            ),
                            shrinkWrap: true,
                            children: [
                              Container(
                                decoration:
                                    ThemeHelper().buttonBoxDecoration(context),
                                margin: EdgeInsets.symmetric(
                                    vertical: 10.h, horizontal: 10.w),
                                child: ElevatedButton(
                                  style: ThemeHelper().buttonStyle(),
                                  child: Text(
                                    'driver\'s list'.tr,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                  onPressed: () {
                                    //After successful login we will redirect to profile page.
                                    Get.to(DriversList());
                                  },
                                ),
                              ),
                              Container(
                                decoration:
                                    ThemeHelper().buttonBoxDecoration(context),
                                margin: EdgeInsets.symmetric(
                                    vertical: 10.h, horizontal: 10.w),
                                child: ElevatedButton(
                                  style: ThemeHelper().buttonStyle(),
                                  child: Text(
                                    'initial turn'.tr,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                  onPressed: () {
                                    //After successful login we will redirect to profile page.
                                    Get.to(const MakeTurn());
                                  },
                                ),
                              ),
                              Container(
                                decoration:
                                    ThemeHelper().buttonBoxDecoration(context),
                                margin: EdgeInsets.symmetric(
                                    vertical: 10.h, horizontal: 10.w),
                                child: ElevatedButton(
                                  style: ThemeHelper().buttonStyle(),
                                  child: Text(
                                    'today\'s trip'.tr,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                              Container(
                                decoration:
                                    ThemeHelper().buttonBoxDecoration(context),
                                margin: EdgeInsets.symmetric(
                                    vertical: 10.h, horizontal: 10.w),
                                child: ElevatedButton(
                                  style: ThemeHelper().buttonStyle(),
                                  child: Text(
                                    'add admin'.tr,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                  onPressed: () {
                                    //After successful login we will redirect to profile page.
                                    Get.to(AddAdmin());
                                  },
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                decoration:
                                    ThemeHelper().buttonBoxDecoration(context),
                                margin: EdgeInsets.symmetric(
                                    vertical: 10.h, horizontal: 10.w),
                                child: ElevatedButton(
                                  style: ThemeHelper().buttonStyle(),
                                  child: Text(
                                    'Confirm Drivers'.tr,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                  onPressed: () {
                                    //After successful login we will redirect to profile page.
                                    Get.to(confirmDriver());
                                  },
                                ),
                              ),
                              Container(
                                decoration:
                                    ThemeHelper().buttonBoxDecoration(context),
                                margin: EdgeInsets.symmetric(
                                    vertical: 10.h, horizontal: 10.w),
                                child: ElevatedButton(
                                  style: ThemeHelper().buttonStyle(),
                                  child: Text('delete account'.tr,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                      textAlign: TextAlign.center),
                                  onPressed: () {
                                    //After successful login we will redirect to profile page.

                                    Get.to(const DeleteDriver());
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }));
  }
}
