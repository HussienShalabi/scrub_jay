import 'package:flutter_map/plugin_api.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:scrub_jay/view/passenger/PassengerDrawer.dart';
import 'package:scrub_jay/view/widgets/myDrawer.dart';
import '../common_screens/theme_helper.dart';
import '../widgets/HeaderWidget.dart';

class PassengerMap extends StatefulWidget {
  const PassengerMap({super.key});

  @override
  State<PassengerMap> createState() => _PassengerMapState();
}

class _PassengerMapState extends State<PassengerMap> {
  LatLng? position;

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
              ])),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(
              top: 5,
              right: 16,
            ),
            child: TextButton(onPressed: (){}, child: const Text('Save',style: TextStyle(color: Colors.white, fontSize: 16),))
          )
        ],
      ),
      drawer: const PassengerDrawer(),
      body: SizedBox(
        child: FlutterMap(
          options: MapOptions(
            center: LatLng(51.509364, -0.128928),
            zoom: 9.2,
            onTap: (tapPosition, point) {
              setState(() {
                position = LatLng(point.latitude, point.longitude);
              });

              print(point);
            },
          ),
          children: [
            TileLayer(
              urlTemplate:
                  'https://api.mapbox.com/styles/v1/hussien-shalabi22/clh7lsnvq00wa01pgago7cbjd/wmts?access_token=pk.eyJ1IjoiaHVzc2llbi1zaGFsYWJpMjIiLCJhIjoiY2xoN2dzM2VyMGZ4MjNkczYzcXdiNGo2biJ9.lw5BisoA_di40d0OqyhfHw',
              additionalOptions: const {
                'accessToken':
                    'pk.eyJ1IjoiaHVzc2llbi1zaGFsYWJpMjIiLCJhIjoiY2xoN2dzM2VyMGZ4MjNkczYzcXdiNGo2biJ9.lw5BisoA_di40d0OqyhfHw',
                // 'id': 'mapbox.mapbox-streets-v8',
              },
            ),
            if (position != null)
              MarkerLayer(
                markers: [
                  Marker(
                    point: position!,
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
      ),
    );
  }
}
