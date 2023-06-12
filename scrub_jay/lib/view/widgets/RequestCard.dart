import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RequestCard extends StatelessWidget {
  final IconData leadingIcon;
  final String passengerName;
  final String passengerPhoneNumber;
  final int passengerCount;
  final String passengerLocation;

  final double BottomMargin;

  const RequestCard({
    this.leadingIcon = Icons.person,
    required this.passengerName,
    required this.passengerCount,
    required this.passengerPhoneNumber,
    required this.passengerLocation,
    this.BottomMargin = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black54,
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      // margin: const EdgeInsets.all(3),
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      elevation: 10,
      child: ListTile(
        leading: Icon(
          leadingIcon,
          color: Colors.white,
          size: 30,
        ),
        title: Row(
          children: [
            Text(
              "name: ".tr,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
              ),
            ),
            Text(
              passengerName,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
              ),
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
                  "$passengerPhoneNumber",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "seats: ".tr,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                  ),
                ),
                Text(
                  "$passengerCount ",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "Location: ".tr,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                  ),
                ),
                Text(
                  passengerLocation.length > 15
                      ? '${passengerLocation.substring(0, 15)}...'
                      : passengerLocation,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
