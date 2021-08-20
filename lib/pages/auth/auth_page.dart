import 'package:daily_planner/pages/auth/login.dart';
import 'package:daily_planner/pages/constants.dart';
import 'package:flutter/material.dart';

import 'register.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  static const REGISTER_TITLE = "Do not have an account?";
  static const LOGIN_TITLE = "Have an account?";
  static const LOGIN_BTN = "Login";
  static const REGISTER_BTN = "Register";

  bool flagRegister = true;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: size.height,
        width: size.width,
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              flagRegister == true ? Register() : Login(),
              const SizedBox(height: 10.0),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Text(
                        flagRegister == true ? LOGIN_TITLE : REGISTER_TITLE,
                        style: TextStyle(
                          fontSize: 15.0,
                          fontFamily: appFont1,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            flagRegister = !flagRegister;
                          });
                        },
                        child: Text(
                          flagRegister == true ? LOGIN_BTN : REGISTER_BTN,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: appFont1,
                            color: Color.fromRGBO(143, 148, 251, 1),
                            decoration: TextDecoration.underline,
                            decorationStyle: TextDecorationStyle.solid,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
