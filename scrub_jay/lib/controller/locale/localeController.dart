
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrub_jay/core/app_shared_preferences.dart';

import '../../main.dart';

class MyLocaleController extends GetxController{
  Locale initialLang = AppSharedPrefernces.appSharedPrefernces.getDate('lang')== null? Get.deviceLocale!: Locale(sharepref!.getString('lang')!);
  void changeLang(String codeLang){
    Locale locale = Locale(codeLang);
    Get.updateLocale(locale);
  }
}