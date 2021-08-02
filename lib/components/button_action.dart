import 'package:daily_planner/pages/constants.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ButtonAction extends StatelessWidget {
  late String title;
  late var onClick;
  late var color;
  ButtonAction({
    required this.title,
    required this.onClick,
    required this.color,
  });
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Center(
      child: InkWell(
        onTap: onClick,
        child: Container(
          width: size.width * 0.75,
          height: size.height * 0.075,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontFamily: appFont1,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
