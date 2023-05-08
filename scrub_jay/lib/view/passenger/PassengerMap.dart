import 'package:flutter_map/plugin_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:scrub_jay/controller/map_controller.dart';
import 'package:scrub_jay/view/passenger/PassengerDrawer.dart';

class PassengerMap extends StatelessWidget {
  const PassengerMap({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              ],
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
      body: GetBuilder<MapControllerImp>(
        init: MapControllerImp(),
        builder: (controller) {
          if (controller.done == false) {
            return Center(
              child: SizedBox(
                child: Text(
                  'Waiting...',
                  style: TextStyle(fontSize: 30.sp),
                ),
              ),
            );
          }

          return SizedBox(
            child: FlutterMap(
              options: MapOptions(
                center: controller.currentLocation != null
                    ? LatLng(controller.currentLocation!.latitude,
                        controller.currentLocation!.longitude)
                    : null,
                zoom: 11,
                onTap: (tapPosition, point) => controller.selectLocation(point),
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
                if (controller.selectedLocation != null)
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: controller.selectedLocation!,
                        builder: (context) => const Icon(
                          Icons.location_history,
                          size: 50,
                          color: Colors.red,
                        ),
                      )
                    ],
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
