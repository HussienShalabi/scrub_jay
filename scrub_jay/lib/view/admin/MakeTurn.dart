import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/widgets.dart';
import 'package:scrub_jay/controller/AdminController.dart';
import '../../model/driver.dart';
import '../common_screens/theme_helper.dart';
import '../widgets/DriverInfoCard.dart';
import '../widgets/headerWidget.dart';
import 'AdminDrawer.dart';

class MakeTurn extends StatefulWidget {
  const MakeTurn({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MakeTurnState();
  }
}

class _MakeTurnState extends State<MakeTurn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'initial turn'.tr,
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
          child: Stack(
            children: [
              const SizedBox(
                height: 100,
                child: HeaderWidget(100, false, Icons.house_rounded),
              ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.fromLTRB(25, 80, 25, 10),
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 500,
                      child: GetBuilder<AdminControllerImp>(
                        init: AdminControllerImp(),
                        builder: (controller) {
                          return ReorderableListView.builder(
                            itemBuilder: (context, index) {
                              return DriverInfoCard(
                                key: Key(controller.drivers[index].id ?? ''),
                                leadingIcon: Icons.taxi_alert_rounded,
                                title: controller.trips.isEmpty
                                    ? controller.drivers[index].fullname ?? ''
                                    : controller.trips[index].driverName ?? '',
                                driverPhoneNumber: controller.trips.isEmpty
                                    ? controller.drivers[index].phoneNumber ??
                                        ''
                                    : controller.trips[index].phone ?? '',
                              );
                            },
                            itemCount: controller.trips.isEmpty
                                ? controller.drivers.length
                                : controller.trips.length,
                            onReorder: (oldIndex, newIndex) =>
                                controller.reorder(oldIndex, newIndex),
                          );
                        },
                      ),
                    ),
                    GetBuilder<AdminControllerImp>(
                        init: AdminControllerImp(),
                        builder: (controller) {
                          return SizedBox(
                            width: 200,
                            child: Container(
                              decoration:
                                  ThemeHelper().buttonBoxDecoration(context),
                              child: ElevatedButton(
                                style: ThemeHelper().buttonStyle(),
                                onPressed: controller.isLoading
                                    ? () {}
                                    : () => controller.saveTrips(),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(40, 10, 40, 10),
                                  child: controller.isLoading
                                      ? const Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : Text(
                                          'Save'.tr.toUpperCase(),
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
