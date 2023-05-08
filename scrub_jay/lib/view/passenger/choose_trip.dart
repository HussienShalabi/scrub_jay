import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scrub_jay/controller/passenger_controller.dart';
import 'package:scrub_jay/view/passenger/PassengerDrawer.dart';
import 'package:scrub_jay/view/passenger/PassengerMap.dart';
import '../common_screens/theme_helper.dart';
import '../widgets/HeaderWidget.dart';
import '../widgets/tripCard.dart';
import '../widgets/myDrawer.dart';

class ChooseTrip extends StatelessWidget {
  ChooseTrip({super.key});

  final PassengerControllerImp passengerControllerImp =
      Get.put(PassengerControllerImp());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow.shade700,
        onPressed: () {
          Get.defaultDialog(
            title: "booking",
            content: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(width: 15),
                  DropdownButtonFormField<int>(
                    decoration: ThemeHelper().textInputDecoration(
                      'Number of passengers'.tr,
                    ),
                    items: [1, 2, 3, 4].map((passenger) {
                      return DropdownMenuItem<int>(
                        value: passenger,
                        child: Text('$passenger'),
                      );
                    }).toList(),
                    value: passengerControllerImp.numberOfPassengers,
                    onChanged: (value) =>
                        passengerControllerImp.selectNumberOfPassenger(value),
                  ),
                  const SizedBox(height: 10),
                  GetBuilder<PassengerControllerImp>(
                    builder: (controller) => Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const SizedBox(
                          child: Text(
                            'Your location:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                          child: RadioListTile(
                            title: const Text('Current location'),
                            value: 0,
                            groupValue: controller.optionMapSelected.value,
                            onChanged: (value) {
                              controller.updateSelectedValue(value!);
                            },
                          ),
                        ),
                        SizedBox(
                          height: 40,
                          child: RadioListTile(
                            title: const Text('Choose from map'),
                            value: 1,
                            groupValue: controller.optionMapSelected.value,
                            onChanged: (value) {
                              controller.updateSelectedValue(value!);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            textConfirm: "book now",
            onConfirm: () {
              if (passengerControllerImp.optionMapSelected.value == 1) {
                Get.to(() => const PassengerMap());
              } else {
                passengerControllerImp.orderTrip();
                Get.back();
              }
            },
          );
          // passengerControllerImp.orderTrip();
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Available Trips".tr,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).colorScheme.secondary,
              ],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 0.0),
              stops: const [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
          ),
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
      drawer: const PassengerDrawer(),
      body: SingleChildScrollView(
        child: Stack(children: [
          SizedBox(
            height: 100,
            child: HeaderWidget(80.h, false, Icons.house_rounded),
          ),
          Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.fromLTRB(5, 80, 5, 10),
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Column(children: [
                const SizedBox(
                  height: 20,
                ),
                GetBuilder<PassengerControllerImp>(
                    init: PassengerControllerImp(),
                    builder: (controller) {
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.trips.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          if (controller.trips.isEmpty) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          return GestureDetector(
                            child: TripCard(
                              leadingIcon: Icons.taxi_alert_rounded,
                              driverPhoneNumber: controller.trips[index].phone!,
                              driverName: controller.trips[index].driverName!,
                              availableSeats: 7 -
                                  controller.trips[index].passengers!.length,
                            ),
                            onTap: () {
                              // Get.defaultDialog(
                              //     title: "booking",
                              //     content: SingleChildScrollView(
                              //         child: ListBody(
                              //       children: [
                              //         Row(
                              //           children: [
                              //             const SizedBox(
                              //               width: 15,
                              //             ),
                              //             const Text("Enter number of passngers",
                              //                 textAlign: TextAlign.center),
                              //             const SizedBox(
                              //               width: 10,
                              //             ),
                              //             Obx(() => DropdownButton<int>(
                              //                   alignment: Alignment.center,
                              //                   value: selectedOption.value,
                              //                   icon: const Icon(
                              //                       Icons.arrow_downward),
                              //                   iconSize: 20,
                              //                   elevation: 16,
                              //                   style: const TextStyle(
                              //                       color: Colors.black),
                              //                   underline: Container(
                              //                     height: 2,
                              //                     color: Colors.yellow.shade700,
                              //                   ),
                              //                   onChanged: (var newValue) {
                              //                     selectedOption.value =
                              //                         newValue!; // Update the selectedOption observable when the user selects a new value
                              //                   },
                              //                   items: options
                              //                       .map<DropdownMenuItem<int>>(
                              //                           (int value) {
                              //                     return DropdownMenuItem<int>(
                              //                       value: value,
                              //                       child: Text(value.toString()),
                              //                     );
                              //                   }).toList(),
                              //                 )),
                              //           ],
                              //         ),
                              //         const SizedBox(
                              //           height: 10,
                              //         ),
                              //         Expanded(
                              //           child: TextFormField(
                              //             textAlign: TextAlign.center,
                              //             decoration: ThemeHelper()
                              //                 .textInputDecoration(
                              //                     'passenger  location'.tr,
                              //                     'Enter passenger  location'.tr),
                              //           ),
                              //         ),
                              //       ],
                              //     )),
                              //     textConfirm: "book now");
                            },
                          );
                        },
                      );
                    })
              ]))
        ]),
      ),
    );
  }
}
