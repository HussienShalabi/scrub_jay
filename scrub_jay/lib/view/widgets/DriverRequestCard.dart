import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scrub_jay/controller/AdminController.dart';
import 'package:scrub_jay/controller/auth_controller.dart';

import '../common_screens/theme_helper.dart';

class DriverRequestCard extends StatelessWidget {
  final IconData leadingIcon;
  final String id;
  final String title;
  final String driverPhoneNumber;
  final String driverEmailAddress;
  final String driverVehicleNumber;
  final String driverIdentityNumber;
  final String driverLicenseNumber;
  final IconData trailing;
  final double bottomMargin;
  final void Function()? onPressed;

  const DriverRequestCard({
    super.key,
    this.leadingIcon = Icons.person,
    required this.id,
    required this.title,
    required this.driverPhoneNumber,
    this.trailing = Icons.check,
    required this.driverEmailAddress,
    required this.driverVehicleNumber,
    required this.driverIdentityNumber,
    required this.driverLicenseNumber,
    this.onPressed,
    this.bottomMargin = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black54,
      margin: EdgeInsets.all(7.sp),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      elevation: 5.sp,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            leadingIcon,
            color: Colors.white,
          ),
          SizedBox(
            height: 220.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    // fontFamily: ('Caveat'),
                  ),
                ),
                Text(
                  'phone: '.tr,
                  style: TextStyle(
                    fontSize: 17.sp,
                    color: Colors.white,
                    // fontFamily: ('Caveat'),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  driverPhoneNumber,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.white,
                    // fontFamily: ('Caveat'),
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Text(
                  'email: '.tr,
                  style: TextStyle(
                    fontSize: 17.sp,
                    color: Colors.white,
                    // fontFamily: ('Caveat'),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '$driverEmailAddress',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.white,
                    // fontFamily: ('Caveat'),
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Text(
                  'Vehicle Number: '.tr,
                  style: TextStyle(
                    fontSize: 17.sp,
                    color: Colors.white,
                    // fontFamily: ('Caveat'),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '$driverVehicleNumber',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.white,
                    // fontFamily: ('Caveat'),
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Text(
                  'Identity Number: '.tr,
                  style: TextStyle(
                    fontSize: 17.sp,
                    color: Colors.white,
                    // fontFamily: ('Caveat'),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '$driverIdentityNumber',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.white,
                    // fontFamily: ('Caveat'),
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Text(
                  'Driver License Number: '.tr,
                  style: TextStyle(
                    fontSize: 17.sp,
                    color: Colors.white,
                    // fontFamily: ('Caveat'),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '$driverLicenseNumber',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.white,
                    // fontFamily: ('Caveat'),
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onPressed,
            icon: Icon(
              trailing,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
