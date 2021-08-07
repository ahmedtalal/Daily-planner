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
    return Container(
      height: message != "Description ..." ? 48.0 : null,
      child: TextFormField(
        onChanged: onClick,
        validator: onValidate,
        maxLines: message == "Description ..." ? 3 : 1,
        decoration: InputDecoration(
          labelText: message,
          prefixIcon: Icon(
            icon,
            color: message == "Search" ? Colors.white : Colors.black54,
            size: 17.0,
          ),
          labelStyle: TextStyle(
            fontFamily: appFont1,
            color: message == "Search" ? Colors.white : Colors.grey[500],
            fontSize: 14.0,
            fontWeight: message == "Search" ? FontWeight.bold : FontWeight.w500,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(
              color: message == "Search" ? Colors.white : Colors.grey,
              width: 0.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(
              color: message == "Search" ? Colors.white : Colors.grey,
              width: 0.5,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(
              color: message == "Search" ? Colors.white : Colors.grey,
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
