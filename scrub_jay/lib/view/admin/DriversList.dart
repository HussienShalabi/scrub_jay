import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/DriverInfoCard.dart';
import '../widgets/HeaderWidget.dart';
import 'AdminDrawer.dart';

class DriversList extends StatefulWidget {
  const DriversList({super.key});
// just show screen from db
  @override
  State<StatefulWidget> createState() {
    return _DriversListState();
  }
}

class _DriversListState extends State<DriversList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'driver\'s list'.tr,
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
                    ListView.builder(
                      itemCount: 5,
                      shrinkWrap: true,
                      itemBuilder: (context, index) => const DriverInfoCard(
                        leadingIcon: Icons.taxi_alert_rounded,
                        title: "data",
                        driverPhoneNumber: 005975,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
