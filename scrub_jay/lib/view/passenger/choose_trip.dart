import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scrub_jay/controller/passenger_controller.dart';
import 'package:scrub_jay/view/passenger/PassengerDrawer.dart';
import 'package:scrub_jay/view/passenger/PassengerMap.dart';
import '../common_screens/theme_helper.dart';
import '../widgets/HeaderWidget.dart';
import '../widgets/tripCard.dart';

class ChooseTrip extends StatelessWidget {
  ChooseTrip({super.key});

  final PassengerControllerImp passengerControllerImp =
      Get.put(PassengerControllerImp());

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
      body: Stack(
        children: [
          SizedBox(
            height: 100,
            child: HeaderWidget(80.h, false, Icons.house_rounded),
          ),
          SingleChildScrollView(
            child: Container(
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
                        if (controller.isLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (controller.trips.isEmpty) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 30).h,
                            child: const Center(
                              child: Text(
                                'Not Found Trips',
                                style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          );
                        }

                        return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.trips.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              child: TripCard(
                                leadingIcon: Icons.taxi_alert_rounded,
                                driverPhoneNumber:
                                    controller.trips[index].phone ?? '',
                                driverName:
                                    controller.trips[index].driverName ?? '',
                                availableSeats: 7 -
                                    (controller.trips[index].totalPassengers ??
                                        0),
                              ),
                              // onTap: () {
                              // },
                            );
                          },
                        );
                      })
                ])),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 500.h),
              decoration: ThemeHelper().buttonBoxDecoration(context),
              child: ElevatedButton(
                style: ThemeHelper().buttonStyle(),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                  child: Text(
                    "Book a ride".tr.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                onPressed: () {
                  Get.defaultDialog(
                    title: "booking".tr,
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
                            onChanged: (value) => passengerControllerImp
                                .selectNumberOfPassenger(value),
                          ),
                          const SizedBox(height: 10),
                          GetBuilder<PassengerControllerImp>(
                            builder: (controller) => Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  child: Text(
                                    'Your location:'.tr,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 40,
                                  child: RadioListTile(
                                    title: Text('Current location'.tr),
                                    value: 0,
                                    groupValue:
                                        controller.optionMapSelected.value,
                                    onChanged: (value) {
                                      controller.updateSelectedValue(value!);
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 40,
                                  child: RadioListTile(
                                    title: Text('Choose from map'.tr),
                                    value: 1,
                                    groupValue:
                                        controller.optionMapSelected.value,
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
                    textConfirm: "book now".tr,
                    buttonColor: Colors.yellow.shade700,
                    confirmTextColor: Colors.white,
                    onConfirm: () {
                      if (passengerControllerImp.optionMapSelected.value == 1) {
                        Get.to(() => const PassengerMap());
                      } else {
                        passengerControllerImp.orderTrip();
                        Get.back();
                      }
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
