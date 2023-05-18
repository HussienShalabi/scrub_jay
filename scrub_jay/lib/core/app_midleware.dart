import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:scrub_jay/core/app_shared_preferences.dart';

class AppMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final int? role =
        AppSharedPrefernces.appSharedPrefernces.getDate('role') as int?;
    if (role != null) {
      if (role == 0) {
        return const RouteSettings(
          name: '/adminMainScreen',
        );
      } else if (role == 1) {
        return const RouteSettings(
          name: '/DriverMainScreen',
        );
      } else if (role == 2) {
        return const RouteSettings(
          name: '/ChooseTrip',
        );
      }
    }
    return null;
  }
}
