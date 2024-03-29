import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scrub_jay/bindings.dart';
import 'package:scrub_jay/core/app_midleware.dart';
import 'package:scrub_jay/core/app_notifications.dart';
import 'package:scrub_jay/core/app_shared_preferences.dart';
import 'package:scrub_jay/core/firebase_app_auth.dart';
import 'package:scrub_jay/firebase_options.dart';
import 'package:scrub_jay/view/Driver/DriverMainScreen.dart';
import 'package:scrub_jay/view/admin/AdminMainScreen.dart';
import 'package:scrub_jay/view/passenger/choose_trip.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'controller/locale/locale.dart';
import 'controller/locale/localeController.dart';
import 'view/common_screens/Signin.dart';
import 'view/common_screens/SplashScreen.dart';

SharedPreferences? sharepref;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppSharedPrefernces.appSharedPrefernces.initSharedPred();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  AppNotifications.appNotifications.intilizeNotifications();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final Color _primaryColor = Colors.yellow.shade700;
  final Color _accentColor = Colors.black54;

  @override
  Widget build(BuildContext context) {
    final MyLocaleControllerImp localeController =
        Get.put(MyLocaleControllerImp());
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Scrub_Jay',
          theme: ThemeData(
            primaryColor: _primaryColor,
            scaffoldBackgroundColor: Colors.grey.shade100,
            colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey)
                .copyWith(secondary: _accentColor),
          ),
          locale: localeController.initialLocale ?? Get.deviceLocale,
          translations: Mylocale(),
          initialRoute: '/SplashScreen',
          initialBinding: Binding(),
          getPages: [
            GetPage(name: '/SplashScreen', page: () => const SplashScreen()),
            GetPage(
              name: '/Signin',
              page: () => const Signin(),
              middlewares: [AppMiddleware()],
            ),
            GetPage(
              name: '/adminMainScreen',
              page: () => const AdminMainScreen(),
            ),
            GetPage(name: '/DriverMainScreen', page: () => DriverMainScreen()),
            GetPage(name: '/ChooseTrip', page: () => ChooseTrip()),
          ],
        );
      },
    );
  }
}
