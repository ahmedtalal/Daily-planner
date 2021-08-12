import 'package:daily_planner/pages/constants.dart';
import 'package:flutter/material.dart';

Widget dataLoadedError() {
  return Center(
    child: Container(
      height: 150,
      child: Column(
        children: [
          Image(
            image: AssetImage(emptyData),
            height: 100,
          ),
          Text(
            "No tasks at this time",
            style: TextStyle(
              fontFamily: appFont1,
              fontSize: 15.0,
            ),
          ),
        ],
      ),
    ),
  );
}
