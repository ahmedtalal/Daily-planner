import 'package:daily_planner/pages/constants.dart';
import 'package:flutter/material.dart';

Widget categoriesWidget({
  required String categoryName,
  required int index,
  required var onClick,
  required var color,
  required var coloredIndex,
}) {
  return InkWell(
    onTap: onClick,
    child: Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(bottom: 5.0),
      height: 38.0,
      width: 95.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40.0),
        color: coloredIndex == index ? color : Colors.grey,
      ),
      child: Text(
        categoryName,
        style: TextStyle(
          fontSize: 15.0,
          fontFamily: appFont1,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ),
  );
}
