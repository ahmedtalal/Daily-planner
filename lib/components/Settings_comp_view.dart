import 'package:daily_planner/pages/constants.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SettingComponentsView extends StatelessWidget {
  var onClick;
  String hint;
  String icon;
  Color color;
  SettingComponentsView({
    required this.onClick,
    required this.hint,
    required this.icon,
    required this.color,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 13.0,
                backgroundColor: color,
                child: Image(
                  image: AssetImage(icon),
                  height: 12.0,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              Text(
                hint,
                style: TextStyle(
                  fontSize: 12.0,
                  fontFamily: appFont1,
                  color: hint == "LogOut" ? Colors.purple : null,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: 13.0,
          ),
        ],
      ),
    );
  }
}
