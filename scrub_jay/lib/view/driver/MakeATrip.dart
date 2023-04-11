import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../common_screens/theme_helper.dart';
import '../widgets/HeaderWidget.dart';
import '../widgets/RequestCard.dart';
import 'DriverDrawer.dart';


class MakeATrip extends StatefulWidget {
  const MakeATrip({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MakeATripState();
  }
}

class _MakeATripState extends State<MakeATrip> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title:  Text(
            "Booked passengers".tr,
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
        drawer: DriverDrawer(),
        body: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 100,
                    child: const HeaderWidget(100, false, Icons.house_rounded),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.fromLTRB(2, 80, 2, 10),
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: 4,
                          shrinkWrap: true,
                          itemBuilder: (context, index) => RequestCard(
                            leadingIcon: Icons.clear,
                              passengerName: 'Abu al-tayeb',
                              passengerCount: 2,
                              passengerPhoneNumber: 059954,
                              passengerLocation: 'behind khaledyah ',
                            trailing: Icons.check,
                              )
                        ),

                      ],
                    ),
                  ),


                ],
              ),
              Container(
                alignment: Alignment.bottomCenter,
                decoration: ThemeHelper().buttonBoxDecoration(
                    context),
                child: ElevatedButton(
                  style: ThemeHelper().buttonStyle(),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                        40, 10, 40, 10),
                    child: Text('Start the trip'.tr,
                      style:  TextStyle(fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),),
                  ),
                  onPressed: () {
                    //After successful login we will redirect to profile page.
                    // Navigator.pushReplacement(context,
                    //     MaterialPageRoute(builder: (context) =>
                    //         TripScreen()));
                    Get.to( MakeATrip());
                  },
                ),
              ),
            ],
          ),

        ));
  }
}
