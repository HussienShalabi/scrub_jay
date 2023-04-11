import 'dart:ui';

import 'package:get/get.dart';

import '../../main.dart';

class MyLocaleController extends GetxController{
  Locale initialLang = sharepref!.getString('lang')== null? Get.deviceLocale!: Locale(sharepref!.getString('lang')!);
  void changeLang(String codeLang){
    Locale locale = Locale(codeLang);
    Get.updateLocale(locale);
  }
}