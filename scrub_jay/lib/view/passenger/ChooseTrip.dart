import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../common_screens/theme_helper.dart';
import '../widgets/HeaderWidget.dart';
import '../widgets/TripCard.dart';
import '../widgets/myDrawer.dart';

class ChooseTrip extends StatelessWidget {
  final List<int> options =
      [1, 2, 3, 4].obs; // Create a GetX observable list of integers

  final RxInt selectedOption =
      1.obs; // Create a GetX observable integer and set it to the first option

  ChooseTrip({super.key});

  String? val;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Available Trips".tr,
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
      drawer: const MyDrawer(),
      body: SingleChildScrollView(
        child: Stack(children: [
          SizedBox(
            height: 100,
            child: HeaderWidget(80.h, false, Icons.house_rounded),
          ),
          Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.fromLTRB(25, 80, 25, 10),
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Column(children: [
                const SizedBox(
                  height: 20,
                ),
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 8,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => InkWell(
                          child: TripCard(
                            leadingIcon: Icons.taxi_alert_rounded,
                            driverPhoneNumber: 05975,
                            trailing: Icons.arrow_forward_ios_rounded,
                            driverName: 'lotfi',
                            availableSeats: 2,
                          ),
                          onTap: () {
                            print("object");

                            Get.defaultDialog(
                                title: "booking",
                                content: SingleChildScrollView(
                                    child: ListBody(
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(width: 15,),
                                        const Text("Enter number of passngers",
                                            textAlign: TextAlign.center),
                                        SizedBox(width: 10,),
                                        Obx(() => DropdownButton<int>(
                                              alignment: Alignment.center,
                                              value: selectedOption.value,
                                              icon: Icon(Icons.arrow_downward),
                                              iconSize: 20,
                                              elevation: 16,
                                              style: TextStyle(color: Colors.black),
                                              underline: Container(
                                                height: 2,
                                                color: Colors.yellow.shade700,
                                              ),
                                              onChanged: (var newValue) {
                                                selectedOption.value =
                                                    newValue!; // Update the selectedOption observable when the user selects a new value
                                              },
                                              items: options
                                                  .map<DropdownMenuItem<int>>(
                                                      (int value) {
                                                return DropdownMenuItem<int>(
                                                  value: value,
                                                  child: Text(value.toString()),
                                                );
                                              }).toList(),
                                            )),
                                      ],
                                    ),

                                    SizedBox(
                                      height: 10,
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        textAlign: TextAlign.center,
                                        decoration: ThemeHelper()
                                            .textInputDecoration(
                                                'passenger  location'.tr,
                                                'Enter passenger  location'.tr),
                                      ),
                                    ),
                                  ],
                                )),
                                textConfirm: "book now");
                          },
                        ))
              ]))
        ]),
      ),
    );
  }
}
