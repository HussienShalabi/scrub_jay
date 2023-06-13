import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:scrub_jay/view/Driver/DriverDrawer.dart';
import 'package:scrub_jay/view/widgets/RequestCard.dart';
import '../../controller/driver_controller.dart';
import '../common_screens/theme_helper.dart';

class DriverMap extends StatelessWidget {
  const DriverMap({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DriverControllerImp>(
        init: DriverControllerImp(),
        builder: (controller) {
          if (controller.getLocations) {
            controller.getPassengersLocations();
          }

          return Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: controller.isLoading
                ? null
                : FloatingActionButton(
                    backgroundColor: Colors.yellow.shade700,
                    onPressed: () => Get.bottomSheet(
                      SingleChildScrollView(
                        child: Container(
                          height: 400,
                          color: Colors.white,
                          child: Column(
                            children: [
                              Expanded(
                                child: controller.passengers.isEmpty
                                    ? Center(
                                        child: Text(
                                          'Not found any orders yet',
                                          style: TextStyle(
                                            fontSize: 20.sp,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      )
                                    : ListView.builder(
                                        itemCount: controller.passengers.length,
                                        itemBuilder: (context, index) =>
                                            InkWell(
                                          child: RequestCard(
                                              passengerName: controller
                                                      .passengers[index]
                                                          ['passenger']
                                                      .fullname ??
                                                  '',
                                              passengerCount:
                                                  controller.passengers[index]
                                                      ['numOfPassenger'],
                                              passengerPhoneNumber: controller
                                                      .passengers[index]
                                                          ['passenger']
                                                      .phoneNumber ??
                                                  '',
                                              passengerLocation:
                                                  controller.passengers[index]
                                                          ['location_name'] ??
                                                      ''),
                                        ),
                                      ),
                              ),
                              if (!controller.save)
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 25),
                                  // alignment: Alignment.bottomCenter,
                                  decoration: ThemeHelper()
                                      .buttonBoxDecoration(context),
                                  child: ElevatedButton(
                                    style: ThemeHelper().buttonStyle(),
                                    onPressed: controller.save
                                        ? () {}
                                        : () => controller.startTrip(),
                                    child: controller.save
                                        ? const Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        : Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 110),
                                            child: Text(
                                              'Start the trip'.tr,
                                              style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    child: const Icon(Icons.arrow_upward),
                  ),
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'My trip'.tr,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
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
            body: controller.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    children: [
                      Expanded(
                        child: FlutterMap(
                          options: MapOptions(
                            center: controller.currentLocation != null
                                ? LatLng(controller.currentLocation!.latitude,
                                    controller.currentLocation!.longitude)
                                : null,
                            zoom: 16,
                          ),
                          children: [
                            TileLayer(
                              urlTemplate:
                                  'https://api.mapbox.com/styles/v1/hussien-shalabi22/clhejahmw015501pn54hg83z3/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiaHVzc2llbi1zaGFsYWJpMjIiLCJhIjoiY2xoN2dzM2VyMGZ4MjNkczYzcXdiNGo2biJ9.lw5BisoA_di40d0OqyhfHw',
                              additionalOptions: const {
                                'accessToken':
                                    'pk.eyJ1IjoiaHVzc2llbi1zaGFsYWJpMjIiLCJhIjoiY2xoN2dzM2VyMGZ4MjNkczYzcXdiNGo2biJ9.lw5BisoA_di40d0OqyhfHw',
                                'id': 'mapbox.mapbox-streets-v8',
                              },
                            ),
                            if (controller.passengers.isNotEmpty)
                              MarkerLayer(
                                markers: controller.passengers.map(
                                  (e) {
                                    return Marker(
                                      point: LatLng(
                                          e['passenger'].location!['latitude']!
                                              as double,
                                          e['passenger'].location!['longitude']!
                                              as double),
                                      builder: (context) {
                                        return const Icon(
                                          Icons.location_history,
                                          size: 40,
                                          color: Colors.red,
                                        );
                                      },
                                    );
                                  },
                                ).toList(),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
          );
        });
  }
}
