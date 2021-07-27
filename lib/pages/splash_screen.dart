import 'package:daily_planner/components/button_action.dart';
import 'package:daily_planner/pages/constants.dart';
import 'package:daily_planner/pages/home.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SafeArea(
          top: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height * 0.09,
              ),
              Center(
                child: Text(
                  "Daily Planner",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: appFont1,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.023,
              ),
              Image(
                height: size.height * 0.45,
                image: AssetImage(
                  splash2,
                ),
              ),
              Container(
                width: size.width * 0.65,
                alignment: Alignment.center,
                child: Text(
                  descriptionSplash,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontFamily: appFont1,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.08,
              ),
              ButtonAction(
                title: "Get Started",
                onClick: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => Home(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
