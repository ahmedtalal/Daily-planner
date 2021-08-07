import 'package:daily_planner/pages/constants.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

// ignore: must_be_immutable
class ActivityView extends StatelessWidget {
  var color;
  final int rating;
  final String title;
  final String desciption;
  final double percent;
  ActivityView({
    required this.color,
    required this.title,
    required this.desciption,
    required this.rating,
    required this.percent,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: color,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 15.0,
          ),
          _circularIndicator(rating),
          SizedBox(
            height: 9.0,
          ),
          _title(title),
        ],
      ),
    );
  }

  Widget _circularIndicator(int rating) {
    return CircularPercentIndicator(
      radius: 50.0,
      animation: true,
      animationDuration: 1200,
      lineWidth: 4.0,
      percent: percent,
      center: new Text(
        rating.toString(),
        style: new TextStyle(
          fontSize: 15.0,
          color: Colors.white,
          fontFamily: appFont1,
          fontWeight: FontWeight.bold,
        ),
      ),
      circularStrokeCap: CircularStrokeCap.butt,
      backgroundColor: Colors.grey,
      progressColor: Colors.white,
    );
  }

  Widget _title(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 14.0,
        fontFamily: appFont1,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }
}
