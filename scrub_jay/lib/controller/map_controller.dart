import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import '../model/map.dart';

abstract class MapController extends GetxController {
  Future<void> determineCurrentLocation();
  Future<void> selectLocation(LatLng location);
}

class MapControllerImp extends MapController {
  LatLng? currentLocation;
  LatLng? selectedLocation;
  int i = 1;

  bool done = false;

  void isDone(bool value) {
    done = value;
    update();
  }

  @override
  Future<void> determineCurrentLocation() async =>
      await Map.getCurrentLocation().then((value) {
        currentLocation = LatLng(value.latitude, value.longitude);
        update();
      });

  @override
  Future<void> selectLocation(LatLng location) async {
    selectedLocation = location;
    update();
  }

  @override
  void onReady() {
    super.onReady();
    isDone(true);
  }
}
