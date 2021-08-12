import 'package:daily_planner/pages/constants.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AuthTextInput extends StatelessWidget {
  late String message;
  late var onClick;
  late var onValidate;
  late IconData icon;
  var initialValue;
  AuthTextInput({
    required this.message,
    required this.icon,
    required this.onClick,
    required this.onValidate,
    required this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: message != "Description ..." ? 48.0 : null,
      child: TextFormField(
        style: TextStyle(
          fontSize: 14.0,
          fontFamily: appFont1,
        ),
        initialValue: initialValue,
        onChanged: onClick,
        validator: onValidate,
        maxLines: message == "Description ..." ? 2 : 1,
        decoration: InputDecoration(
          labelText: message,
          prefixIcon: Icon(
            icon,
            color: Colors.black54,
            size: 17.0,
          ),
          labelStyle: TextStyle(
            fontFamily: appFont1,
            color: Colors.grey[500],
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(
              color: Colors.grey,
              width: 0.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(
              color: Colors.grey,
              width: 0.5,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(
              color: Colors.grey,
              width: 0.5,
            ),
          ),
        ),
        obscureText: message.toLowerCase() == "password" ? true : false,
        keyboardType: message.toLowerCase() == "name"
            ? TextInputType.text
            : TextInputType.emailAddress,
      ),
    );
  }
}
