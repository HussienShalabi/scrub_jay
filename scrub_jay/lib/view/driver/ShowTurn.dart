import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrub_jay/controller/driver_controller.dart';
import '../widgets/DriverInfoCard.dart';
import '../widgets/HeaderWidget.dart';
import 'DriverDrawer.dart';

class ShowTurn extends StatefulWidget {
  const ShowTurn({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ShowTurnState();
  }
}

class _ShowTurnState extends State<ShowTurn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Driver\'s Turn'.tr,
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
                        GetBuilder<DriverControllerImp>(
                          init: DriverControllerImp(),
                          builder: (controller) {
                            return ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemCount: controller.trips.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return DriverInfoCard(
                                  leadingIcon: Icons.person,
                                  title: controller.trips[index].driverName!,
                                  driverPhoneNumber:
                                      controller.trips[index].phone ?? '00',
                                );
                              },
                            );
                          },
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
