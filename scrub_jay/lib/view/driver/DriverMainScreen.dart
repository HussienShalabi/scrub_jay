import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../common_screens/theme_helper.dart';
import '../widgets/HeaderWidget.dart';
import 'DriverDrawer.dart';
import 'MakeATrip.dart';
import '../Passenger/ChooseTrip.dart';
import 'ShowTurn.dart';

class DriverMainScreen extends StatefulWidget {
  const DriverMainScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _DriverMainScreenState();
  }
}

class _DriverMainScreenState extends State<DriverMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title:  Text(
            "Driver main page".tr,
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
          child: Stack(
            children: [
              Container(
                height: 100,
                child: const HeaderWidget(100, false, Icons.house_rounded),
              ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.fromLTRB(25, 120, 25, 10),
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child:
                Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    // ListView.builder(
                    //   itemCount: 5,
                    //   shrinkWrap: true,
                    //   itemBuilder: (context, index) => const BioCard(
                    //       leadingIcon: Icons.ios_share,
                    //       title: "title",
                    //       subTitle: "subTitle",
                    //       driverPhoneNumber: 05975,
                    //       trailing: Icons.ice_skating_rounded),
                    // ),
                    GridView(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        mainAxisSpacing: 40,
                        mainAxisExtent: 90,
                      ),
                       shrinkWrap: true,
                      children:  [

                        Container(
                          decoration: ThemeHelper().buttonBoxDecoration(
                              context),
                          child: ElevatedButton(
                            style: ThemeHelper().buttonStyle(),
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(
                                  40, 10, 40, 10),
                              child: Text('make a trip'.tr,
                                style:  TextStyle(fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),),
                            ),
                            onPressed: () {
                              Get.to( MakeATrip());
                            },
                          ),
                        ),
                        Container(
                          decoration: ThemeHelper().buttonBoxDecoration(
                              context),
                          child: ElevatedButton(
                            style: ThemeHelper().buttonStyle(),
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(
                                  40, 10, 40, 10),
                              child: Text('Driver\'s Turn'.tr,
                                style:  const TextStyle(fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),),
                            ),
                            onPressed: () {
                              //After successful login we will redirect to profile page.
                              // Navigator.pushReplacement(context,
                              //     MaterialPageRoute(builder: (context) =>
                              //         TripScreen()));
                              Get.to(const ShowTurn());
                            },
                          ),
                        ),
                        Container(
                          decoration: ThemeHelper().buttonBoxDecoration(
                              context),
                          child: ElevatedButton(
                            style: ThemeHelper().buttonStyle(),
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(
                                  40, 10, 40, 10),
                              child: Text('show news'.tr,
                                style:  const TextStyle(fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),),
                            ),
                            onPressed: () {
                              //After successful login we will redirect to profile page.
                              // Navigator.pushReplacement(context,
                              //     MaterialPageRoute(builder: (context) =>
                              //         TripScreen()));
                              //TODO  make and goes to news screen

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
        ));
  }
}
