import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DriverInfoCard extends StatelessWidget {
  final IconData leadingIcon;
  final String title;
  final String driverPhoneNumber;
  final double BottomMargin;
  final Key? key;

  const DriverInfoCard(
      {required this.leadingIcon,
      required this.title,
      required this.driverPhoneNumber,
      this.key,
      this.BottomMargin = 0});

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
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
            // fontFamily: ('Caveat'),
          ),
        ),
        subtitle: Row(
          children: [
            Text(
              'phone: '.tr,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.white,
                fontWeight: FontWeight.normal,
              ),
            ),
            Text(
              driverPhoneNumber,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.white,
                // fontFamily: ('Caveat'),
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
