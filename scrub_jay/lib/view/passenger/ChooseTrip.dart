

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../widgets/HeaderWidget.dart';
import '../widgets/TripCard.dart';
import '../widgets/myDrawer.dart';
import 'PassengerDrawer.dart';


class ChooseTrip extends StatefulWidget {
  const ChooseTrip({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ChooseTripState();
  }
}

class _ChooseTripState extends State<ChooseTrip> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title:  Text(
            "Available Trips".tr,
            style: TextStyle(
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
        drawer: MyDrawer(),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                height: 100,
                child:  HeaderWidget(80.h, false, Icons.house_rounded),
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
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 8,
                      shrinkWrap: true,
                      itemBuilder: (context, index) => TripCard(
                        leadingIcon: Icons.taxi_alert_rounded,
                        driverPhoneNumber: 05975,
                        trailing: Icons.arrow_forward_ios_rounded,
                        driverName: 'lotfi',
                        availableSeats: 2,
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
