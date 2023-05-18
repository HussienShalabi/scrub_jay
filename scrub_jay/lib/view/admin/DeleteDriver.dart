import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrub_jay/controller/AdminController.dart';
import '../widgets/DriverRequestCard.dart';
import '../widgets/HeaderWidget.dart';
import 'AdminDrawer.dart';

class DeleteDriver extends StatelessWidget {
  const DeleteDriver({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Delete a Driver".tr,
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
                        GetBuilder<AdminControllerImp>(
                          init: AdminControllerImp(),
                          builder: (controller) {
                            return ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                itemCount: controller.drivers.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) =>DriverRequestCard(
                                  leadingIcon: Icons.person,
                                  title: controller.drivers[index].fullname ?? " ",
                                  driverPhoneNumber: controller.drivers[index].phoneNumber ?? " ",
                                  driverEmailAddress: controller.drivers[index].emailAddress ?? " " ,
                                  driverVehicleNumber: controller.drivers[index].vehicleNumber ?? " " ,
                                  driverIdentityNumber: controller.drivers[index].driverIdentityNumber ?? " " ,
                                  driverLicenseNumber: controller.drivers[index].licenseNumber ?? " " ,
                                  trailing: Icons.restore_from_trash_rounded,
                                ),
                            );
                          }
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
