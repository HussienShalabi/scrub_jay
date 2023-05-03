import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import '../core/app_apis.dart';
import '../core/app_http.dart';

class Map {
  Map._();

  static Future<void> getPath(LatLng location1, LatLng location2) async =>
      await AppHttp.appHttp.getRequest(MapApis.pathApi(location1, location2));

  static Future<http.Response?> getLocationDescription(LatLng location) async =>
      await AppHttp.appHttp.getRequest(MapApis.geocodingApi(location));
}
