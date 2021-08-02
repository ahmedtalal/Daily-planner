import 'package:daily_planner/pages/constants.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AuthTextInput extends StatelessWidget {
  late String message;
  late var onClick;
  late var onValidate;
  late IconData icon;
  AuthTextInput({
    required this.message,
    required this.icon,
    required this.onClick,
    required this.onValidate,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onClick,
      validator: onValidate,
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
            width: 0.4,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(
            color: Colors.grey,
            width: 0.4,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(
            color: Colors.grey,
            width: 0.4,
          ),
        ),
      ),
      obscureText: message.toLowerCase() == "password" ? true : false,
      keyboardType: message.toLowerCase() == "name"
          ? TextInputType.text
          : TextInputType.emailAddress,
    );
  }
}
