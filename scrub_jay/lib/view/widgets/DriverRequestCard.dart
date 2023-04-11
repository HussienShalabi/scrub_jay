import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DriverRequestCard extends StatefulWidget {
  final IconData leadingIcon;
  final String title;
  final int driverPhoneNumber;
  final IconData trailing;
  final double BottomMargin;

  const DriverRequestCard({
    required this.leadingIcon,
    required this.title,
    required this.driverPhoneNumber,
    required this.trailing,
    this.BottomMargin = 0,
  });

  @override
  State<DriverRequestCard> createState() => _DriverRequestCardState();
}

class _DriverRequestCardState extends State<DriverRequestCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black54,
      margin: EdgeInsets.all(7.sp),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      elevation: 5.sp,
      child: ListTile(
        leading: Icon(
          widget.leadingIcon,
          color: Colors.white,
        ),
        title: Text(
          widget.title,
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
                // fontFamily: ('Caveat'),
                fontWeight: FontWeight.normal,
              ),
            ),
            Text(
              '${widget.driverPhoneNumber}',
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
            widget.trailing,
            color: Colors.green,
          ),
        ),
      ),
    );
  }
}
