import 'package:daily_planner/pages/constants.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SwitchPages extends StatelessWidget {
  var onClick, title;
  SwitchPages({
    required this.title,
    required this.onClick,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: onClick,
          child: Icon(
            Icons.arrow_back_ios,
            size: 20.0,
            color: title == "search" ? Colors.white : Colors.black,
          ),
        ),
        Text(
          title == "search" ? "" : title,
          style: TextStyle(
            fontSize: 17.0,
            fontFamily: appFont1,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
