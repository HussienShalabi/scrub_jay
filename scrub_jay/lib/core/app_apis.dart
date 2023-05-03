import 'package:latlong2/latlong.dart';

class MapApis {
  static const String accessToken =
      'pk.eyJ1IjoibW9oYW5hZGpheSIsImEiOiJjbGV6ZjQyZHgwd2pqM3hwNDNtaWhqNmZ2In0.iDlQzkQaCl52mTNQYhM_3A';

  static const String mapBoxApi =
      'https://api.mapbox.com/styles/v1/mohanadjay/cleze9olr000301qk23kxuo6x/tiles/256/{z}/{x}/{y}@2x?access_token=$accessToken';
  static String Function(LatLng currentLocation,
      LatLng destinationLocation) pathApi = (LatLng currentLocation,
          LatLng destinationLocation) =>
      'https://api.mapbox.com/directions/v5/mapbox/driving/${currentLocation.longitude},${currentLocation.latitude};${destinationLocation.longitude},${destinationLocation.latitude}?alternatives=true&geometries=polyline&access_token=$accessToken';

  static String Function(LatLng location) geocodingApi = (LatLng location) =>
      'https://api.mapbox.com/geocoding/v5/mapbox.places/${location.longitude},${location.latitude}.json?limit=1&access_token=$accessToken';
}
