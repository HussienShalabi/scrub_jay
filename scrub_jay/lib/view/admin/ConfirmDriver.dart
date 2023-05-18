import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrub_jay/controller/AdminController.dart';
import 'package:scrub_jay/view/admin/AdminDrawer.dart';
import '../../controller/driver_controller.dart';
import '../widgets/DriverRequestCard.dart';
import '../widgets/HeaderWidget.dart';

class confirmDriver extends StatelessWidget {

  final DriverControllerImp driverController = Get.find<DriverControllerImp>();


  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminControllerImp>(
      init: AdminControllerImp(),
      builder: (controller) {
        return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'Confirm Drivers'.tr,
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
              physics: const ScrollPhysics(),
              child: Column(
                children: [
                  Stack(
                    children: [
                      const SizedBox(
                        height: 100,
                        child: HeaderWidget(100, false, Icons.house_rounded),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.fromLTRB(5, 80, 5, 10),
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                itemCount: 7,
                                shrinkWrap: true,
                                itemBuilder: (context, index) =>
                                    const DriverRequestCard(
                                      leadingIcon: Icons.check_sharp,
                                      title: 'anas',
                                      driverPhoneNumber: 1101245,
                                      trailing: Icons.arrow_forward_ios_rounded,
                                    )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ));
      }
    );
  }
}
