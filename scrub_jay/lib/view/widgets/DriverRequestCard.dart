import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DriverRequestCard extends StatelessWidget {
  final IconData leadingIcon;
  final String title;
  final int driverPhoneNumber;
  final IconData trailing;
  final double BottomMargin;

  const DriverRequestCard({
    this.leadingIcon = Icons.person,
    required this.title,
    required this.driverPhoneNumber,
    required this.trailing,
    this.BottomMargin = 0,
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
            fontSize: 15,
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
                // fontFamily: ('Caveat'),
                fontWeight: FontWeight.normal,
              ),
            ),
            Text(
              '$driverPhoneNumber',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.white,
                // fontFamily: ('Caveat'),
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        trailing: IconButton(
          //TODO Show attachments
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
