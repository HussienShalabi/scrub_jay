import 'package:flutter_map/flutter_map.dart';
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
                          child: Column(children: [
                            Expanded(
                              child: ListView.builder(
                                itemCount: controller.passengers.length,
                                itemBuilder: (context, index) => InkWell(
                                  child: RequestCard(
                                      passengerName: controller
                                              .passengers[index]['passenger']
                                              .fullname ??
                                          '',
                                      passengerCount: controller
                                          .passengers[index]['numOfPassenger'],
                                      passengerPhoneNumber: controller
                                              .passengers[index]['passenger']
                                              .phoneNumber ??
                                          '',
                                      passengerLocation: 'iktaba'),
                                ),
                              ),
                            ),
                            Container(
                              // alignment: Alignment.bottomCenter,
                              decoration:
                                  ThemeHelper().buttonBoxDecoration(context),
                              child: ElevatedButton(
                                style: ThemeHelper().buttonStyle(),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 110),
                                  child: Text(
                                    'Start the trip'.tr,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                                onPressed: () async {
                                  await controller.addTrip();
                                },
                              ),
                            ),
                          ]),
                        ),
                      ),
                    ),
                    child: const Icon(Icons.arrow_upward),
                  ),
            appBar: AppBar(
              centerTitle: true,
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
                      ),
                    ],
                  ),
                )
              ],
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
                            zoom: 11,
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
                                          size: 50,
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
