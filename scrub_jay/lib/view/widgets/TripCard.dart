import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../common_screens/theme_helper.dart';

class TripCard extends StatelessWidget {
  final IconData leadingIcon;
  final String driverName;
  final String driverPhoneNumber;
  // final IconData trailing;
  final double bottomMargin;
  final int availableSeats;

  TripCard({
    required this.leadingIcon,
    required this.driverName,
    required this.availableSeats,
    required this.driverPhoneNumber,
    this.bottomMargin = 0,
  });

  var selectedValue = 1;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black45,
      margin: const EdgeInsets.symmetric(vertical: 7),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      elevation: 10,
      child: SizedBox(
        child: ListTile(
          leading: Icon(
            leadingIcon,
            color: Colors.white,
            size: 20.sp,
          ),
          title: Row(
            children: [
              Text(
                "driver name: ".tr,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                ),
              ),
              Text(
                "$driverName",
                style: TextStyle(
                  color: Colors.yellow.shade700,
                  fontSize: 18.sp,
                ),
              ),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "phone: ".tr,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                    ),
                  ),
                  Text(
                    driverPhoneNumber,
                    style: TextStyle(
                      color: Colors.yellow.shade700,
                      fontSize: 18.sp,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "available seats: ".tr,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                    ),
                  ),
                  Text(
                    "$availableSeats ",
                    style: TextStyle(
                      color: Colors.yellow.shade700,
                      fontSize: 18.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),
          // trailing: IconButton(
          //   onPressed: () {
          //   },
          //   icon: Icon(
          //     widget.trailing,
          //     color: Colors.white,
          //   ),
          // ),
        ),
      ),
    );
  }
}
