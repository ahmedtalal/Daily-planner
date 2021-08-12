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
    var size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onClick,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 13.0,
            backgroundColor: color,
            child: Icon(
              icon,
              size: 12.0,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 9.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14.0,
                  fontFamily: appFont1,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 4.0,
              ),
              Text(
                sunTitle,
                style: TextStyle(
                  fontSize: 12.0,
                  fontFamily: appFont1,
                  color: Colors.black54,
                ),
              ),
              SizedBox(
                height: 6.0,
              ),
              Container(
                height: 0.8,
                width: size.width * 0.8,
                color: Colors.grey,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
