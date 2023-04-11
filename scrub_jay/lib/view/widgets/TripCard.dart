import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common_screens/theme_helper.dart';

class TripCard extends StatefulWidget {
  final IconData leadingIcon;
  final String driverName;
  final int driverPhoneNumber;
  final IconData trailing;
  final double BottomMargin;
  final int availableSeats ;

  TripCard({
    required this.leadingIcon,
    required this.driverName,
    required this.trailing,
    required this.availableSeats,
    required this.driverPhoneNumber,
    this.BottomMargin = 0,
  });

  @override
  State<TripCard> createState() => _TripCardState();
}

class _TripCardState extends State<TripCard> {
  // final _seatsController = Get.put(SeatsController());

  var selectedValue = 1;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black45,
      margin: const EdgeInsets.all(3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      elevation: 10,
      child: Container(
        child: ListTile(
          leading: Icon(
            widget.leadingIcon,
            color: Colors.white,
          ),
          title: Row(
            children: [
              Text(
                "driver name: ".tr,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              Text(
                "${widget.driverName}",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
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
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "${widget.driverPhoneNumber}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "available seats: ".tr,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "${widget.availableSeats} ",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ],
          ),
          trailing: IconButton(
            onPressed: () {
            },
            icon: Icon(
              widget.trailing,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
