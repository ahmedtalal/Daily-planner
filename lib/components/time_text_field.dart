import 'package:daily_planner/pages/constants.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TimeTextField extends StatelessWidget {
  late String message;
  late var onClick;
  late var onValidate;
  late IconData icon;
  TimeTextField({
    required this.message,
    required this.icon,
    required this.onClick,
    required this.onValidate,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42.0,
      width: 140.0,
      child: TextFormField(
        style: TextStyle(
          fontSize: 14.0,
          fontFamily: appFont1,
        ),
        onChanged: onClick,
        validator: onValidate,
        decoration: InputDecoration(
          hintText: message,
          hintStyle: TextStyle(
            fontSize: 13.0,
            fontFamily: appFont1,
            color: Colors.black,
          ),
          prefixIcon: Icon(
            icon,
            color: Colors.black,
            size: 15.0,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(
              color: Colors.grey,
              width: 0.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(
              color: Colors.grey,
              width: 0.5,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(
              color: Colors.grey,
              width: 0.5,
            ),
          ),
        ),
        keyboardType: message.toLowerCase() == "name"
            ? TextInputType.text
            : TextInputType.emailAddress,
      ),
    );
  }
}
