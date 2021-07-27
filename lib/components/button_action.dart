import 'package:daily_planner/pages/constants.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ButtonAction extends StatelessWidget {
  late String title;
  late var onClick;
  ButtonAction({
    required this.title,
    required this.onClick,
  });
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Center(
      child: InkWell(
        onTap: onClick,
        child: Container(
          width: size.width * 0.73,
          height: size.height * 0.072,
          decoration: BoxDecoration(
            color: appColor,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontFamily: appFont1,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
