import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controller/locale/locale.dart';
import 'controller/locale/localeController.dart';
import 'view/common_screens/Signin.dart';
import 'view/common_screens/SplashScreen.dart';

SharedPreferences? sharepref;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharepref = await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final Color _primaryColor = Colors.yellow.shade700;
  final Color _accentColor = Colors.black54;

  @override
  Widget build(BuildContext context) {
    Get.put(MyLocaleController());
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (context , child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Scrub_Jay',
          theme: ThemeData(
            primaryColor: _primaryColor,
            scaffoldBackgroundColor: Colors.grey.shade100,
            colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey)
                .copyWith(secondary: _accentColor),
          ),
          locale: Get.deviceLocale,
          translations: Mylocale(),
          initialRoute: '/SplashScreen',
          routes: {
            '/SplashScreen': (context) => const SplashScreen(
              title: 'Scrub Jay',
            ),
            '/Signin': (context) => const Signin(),
          },
        );
      },

    );
  }
}

