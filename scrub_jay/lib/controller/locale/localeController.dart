import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrub_jay/core/app_shared_preferences.dart';

import '../../main.dart';

abstract class MyLocaleController extends GetxController {
  Future<void> changeLocale(String codeLang);
}

class MyLocaleControllerImp extends MyLocaleController {
  Locale? initialLocale;

  @override
  Future<void> changeLocale(String codeLang) async {
    Locale locale = Locale(codeLang);
    AppSharedPrefernces.appSharedPrefernces.setData('lang', codeLang);

    Get.updateLocale(locale);
  }

  @override
  void onInit() {
    super.onInit();
    final String? lang =
        AppSharedPrefernces.appSharedPrefernces.getDate('lang') as String?;

    if (lang != null) {
      initialLocale = Locale(lang);
    }
  }
}
