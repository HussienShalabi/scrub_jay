import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequestCard extends StatefulWidget {
  final IconData leadingIcon;
  final String passengerName;
  final int passengerPhoneNumber;
  final int passengerCount;
  final IconData trailing;
  final String passengerLocation;

  final double BottomMargin;

  const RequestCard({
    required this.leadingIcon,
    required this.passengerName,
    required this.passengerCount,
    required this.passengerPhoneNumber,
    required this.passengerLocation,
    this.BottomMargin = 0,
    required this.trailing,
  });

  @override
  State<RequestCard> createState() => _RequestCardState();
}

class _RequestCardState extends State<RequestCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Card(
        color: Colors.black54,
        margin: const EdgeInsets.all(3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        elevation: 10,
        child: ListTile(
          minLeadingWidth: 10,
          leading: IconButton(
            onPressed: () {},
            icon: Icon(
              widget.leadingIcon,
              color: Colors.red,
            ),
          ),
          title: Row(
            children: [
              Text(
                "name: ".tr,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              Text(
                widget.passengerName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
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
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "${widget.passengerPhoneNumber}",
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
                    "seats: ".tr,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "${widget.passengerCount} ",
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
                    "Location: ".tr,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "${widget.passengerLocation} ",
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
            onPressed: () => {} ,
            icon: Icon(
              widget.trailing,
              color: Colors.green,
            ),
          ),
        ),
      ),
    );
  }
}
