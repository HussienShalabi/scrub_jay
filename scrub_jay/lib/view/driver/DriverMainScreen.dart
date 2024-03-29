import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:scrub_jay/controller/driver_controller.dart';
import 'package:scrub_jay/view/driver/DriverMap.dart';
import '../common_screens/theme_helper.dart';
import '../widgets/HeaderWidget.dart';
import 'DriverDrawer.dart';
import 'MakeATrip.dart';
import 'ShowTurn.dart';

class DriverMainScreen extends StatelessWidget {
  DriverMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Driver main page".tr,
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

        ),
        drawer: const DriverDrawer(),
        body: GetBuilder<DriverControllerImp>(
            init: DriverControllerImp(),
            builder: (controller) {
              if (controller.isLoading || controller.isGetInformation) {
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
                              crossAxisCount: 1,
                              mainAxisSpacing: 40,
                              mainAxisExtent: 90,
                            ),
                            shrinkWrap: true,
                            children: [
                              Container(
                                decoration:
                                    ThemeHelper().buttonBoxDecoration(context),
                                child: ElevatedButton(
                                  style: ThemeHelper().buttonStyle(),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        40, 10, 40, 10),
                                    child: Text(
                                      'My trip'.tr,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                  onPressed: () {
                                    Get.to(const DriverMap());
                                  },
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
                                      'Driver\'s Turn'.tr,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                  onPressed: () {
                                    Get.to(const ShowTurn());
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
