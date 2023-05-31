import 'package:flutter_map/plugin_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:scrub_jay/controller/passenger_controller.dart';
import '../common_screens/theme_helper.dart';

class PassengerMap extends StatelessWidget {
  const PassengerMap({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Point your location".tr,
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
              ],
            ),
          ),
        ),
      ),
      // drawer: const PassengerDrawer(),
      body: Stack(children: [
        GetBuilder<PassengerControllerImp>(
          init: PassengerControllerImp(),
          builder: (controller) {
            return SizedBox(
              child: FlutterMap(
                options: MapOptions(

                  center: controller.currentLocation != null
                      ? LatLng(controller.currentLocation!.latitude, //خطوط الطول والعرض
                          controller.currentLocation!.longitude)
                      : null,
                  zoom: 11,
                  onTap: (tapPosition, point) =>
                      controller.selectDestination(point),
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
                  if (controller.destinationLocation != null)
                    MarkerLayer(
                      markers: [
                        if (controller.destinationLocation != null)
                          Marker(
                            point: controller.destinationLocation!,
                            builder: (context) => const Icon(
                              Icons.location_history,
                              size: 50,
                              color: Colors.red,
                            ),
                          ),
                      ],
                    ),
                ],
              ),
            );
          },
        ),
        GetBuilder<PassengerControllerImp>(
            init: PassengerControllerImp(),
            builder: (controller) {
              return Center(
                child: Container(
                  margin: EdgeInsets.only(top: 500.h),
                  decoration: ThemeHelper().buttonBoxDecoration(context),
                  child: ElevatedButton(
                    style: ThemeHelper().buttonStyle(),
                    onPressed: controller.isLoading
                        ? () {}
                        : () async => await controller.orderTrip(),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                      child: Text(
                        controller.isLoading
                            ? "Waiting".tr
                            : "Save Location".tr.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
      ]),
    );
  }
}
