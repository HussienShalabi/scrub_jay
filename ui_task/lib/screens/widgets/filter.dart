import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class filter extends StatelessWidget {
  final String filterType;
  final Color backGroundColor;
  final Color textColor;

  const filter({required this.filterType, required this.backGroundColor, required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.symmetric(vertical: 5,horizontal: 15),
      decoration: BoxDecoration(
        color: backGroundColor,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Text(filterType,style: TextStyle(fontSize: 15, color: textColor)),
    );
  }
}
