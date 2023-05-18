import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../common_screens/theme_helper.dart';

class DriverRequestCard extends StatelessWidget {
  final IconData leadingIcon;
  final String title;
  final String driverPhoneNumber;
  final String driverEmailAddress;
  final String driverVehicleNumber;
  final String driverIdentityNumber;
  final String driverLicenseNumber;
  final IconData trailing;
  final double BottomMargin;

  const DriverRequestCard({
    super.key,
    this.leadingIcon = Icons.person,
    required this.title,
    required this.driverPhoneNumber,
    this.trailing = Icons.check,
    this.BottomMargin = 0,
    required this.driverEmailAddress,
    required this.driverVehicleNumber,
    required this.driverIdentityNumber,
    required this.driverLicenseNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black54,
      margin: EdgeInsets.all(7.sp),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      elevation: 5.sp,
      child: ListTile(
        leading: Icon(
          leadingIcon,
          color: Colors.white,
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
            // fontFamily: ('Caveat'),
          ),
        ),
        subtitle: SizedBox(
          height: 240,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                '$driverPhoneNumber',
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
        trailing: IconButton(
          onPressed: () => {},
          icon: Icon(
            trailing,
            color: Colors.green,
          ),
        ),
      ),
    );
  }
}
