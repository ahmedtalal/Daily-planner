import 'package:daily_planner/pages/constants.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HomeBody extends StatelessWidget {
  String title, sunTitle;
  Color color;
  var onClick;
  IconData icon;
  HomeBody({
    required this.icon,
    required this.color,
    required this.title,
    required this.sunTitle,
    required this.onClick,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 16.0,
            backgroundColor: color,
            child: Icon(
              icon,
              size: 16.0,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 9.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 17.0,
                  fontFamily: appFont1,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                sunTitle,
                style: TextStyle(
                  fontSize: 12.0,
                  fontFamily: appFont1,
                  fontWeight: FontWeight.bold,
                  color: Colors.black26,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
