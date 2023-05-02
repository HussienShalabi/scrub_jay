import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:scrub_jay/view/Driver/DriverDrawer.dart';
import 'package:scrub_jay/view/admin/DeleteDriver.dart';
import 'package:scrub_jay/view/passenger/PassengerDrawer.dart';
import 'package:scrub_jay/view/widgets/DriverInfoCard.dart';
import 'package:scrub_jay/view/widgets/RequestCard.dart';
import 'package:scrub_jay/view/widgets/myDrawer.dart';
import '../common_screens/theme_helper.dart';
import '../widgets/HeaderWidget.dart';

class DriverMap extends StatelessWidget {
  const DriverMap({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow.shade700,
        onPressed: () => Get.bottomSheet(SingleChildScrollView(
          child: Container(
            height: 300,
            color: Colors.white,
            child: ListView.builder(
              itemCount: 8,
              itemBuilder: (context, index) => const InkWell(
                child: RequestCard(
                    passengerName: "Hus",
                    passengerCount: 3,
                    passengerPhoneNumber: 0592,
                    passengerLocation: 'iktaba'),
              ),
            ),
          ),
        )),
        child: const Icon(Icons.arrow_upward),
      ),
      appBar: AppBar(
        centerTitle: true,
        // title: Text(
        //   "".tr,
        //   style: const TextStyle(
        //     color: Colors.white,
        //     fontWeight: FontWeight.bold,
        //   ),
        // ),
        // elevation: 0.5,
        // iconTheme: const IconThemeData(color: Colors.white),
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
      drawer: const DriverDrawer(),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
