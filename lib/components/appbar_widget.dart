import 'package:daily_planner/pages/constants.dart';
import 'package:flutter/material.dart';

class AppbarWidget {
  static getAppBar(String title, BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(
          fontSize: 19.0,
          fontFamily: appFont1,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      backgroundColor: homeColor,
      elevation: 0.0,
      leading: InkWell(
        onTap: () => Navigator.of(context).pop(),
        child: Icon(
          Icons.arrow_back_ios,
          size: 18.0,
          color: Colors.white,
        ),
      ),
      titleSpacing: -7.0,
      toolbarHeight: 85.0,
      leadingWidth: 45.0,
    );
  }
}
