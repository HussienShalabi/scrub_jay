import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrub_jay/controller/AdminController.dart';
import 'package:scrub_jay/view/admin/AdminDrawer.dart';
import '../../controller/driver_controller.dart';
import '../widgets/DriverRequestCard.dart';
import '../widgets/HeaderWidget.dart';

class confirmDriver extends StatelessWidget {
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
                          padding: const EdgeInsets.fromLTRB(10, 0, 5, 10),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              GetBuilder<AdminControllerImp>(
                                  init: AdminControllerImp(),
                                  builder: (controller) {
                                    return ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      itemCount: controller.newDrivers.length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) =>
                                          DriverRequestCard(
                                        id: controller.newDrivers[index].id ??
                                            '',
                                        leadingIcon: Icons.person,
                                        title: controller
                                                .newDrivers[index].fullname ??
                                            " ",
                                        driverPhoneNumber: controller
                                                .newDrivers[index]
                                                .phoneNumber ??
                                            " ",
                                        trailing: Icons.check,
                                        onPressed: () =>
                                            controller.confirmDriver(
                                                index,
                                                controller
                                                        .newDrivers[index].id ??
                                                    ''),
                                        driverEmailAddress: controller
                                                .newDrivers[index]
                                                .emailAddress ??
                                            " ",
                                        driverVehicleNumber: controller
                                                .newDrivers[index]
                                                .vehicleNumber ??
                                            " ",
                                        driverIdentityNumber: controller
                                                .newDrivers[index]
                                                .driverIdentityNumber ??
                                            " ",
                                        driverLicenseNumber: controller
                                                .newDrivers[index]
                                                .licenseNumber ??
                                            " ",
                                      ),
                                    );
                                  }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ));
        });
  }
}
