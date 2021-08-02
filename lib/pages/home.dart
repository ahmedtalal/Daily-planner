import 'package:cached_network_image/cached_network_image.dart';
import 'package:daily_planner/components/home_body.dart';
import 'package:daily_planner/pages/constants.dart';
import 'package:daily_planner/pages/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: homeColor,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: size.height * 0.3,
              decoration: BoxDecoration(
                color: homeColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40.0),
                  bottomRight: Radius.circular(40.0),
                ),
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => Settings(),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.settings,
                        size: 18.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: size.height * 0.1,
                          width: size.width * 0.3,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: borderColor,
                              width: 2.5,
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 20.0,
                            backgroundColor: homeColor,
                            child: Image(
                              image: AssetImage(userImage),
                              height: 40.0,
                              width: 40.0,
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              "Ahmed Talal",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontFamily: appFont1,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Orginal User",
                              style: TextStyle(
                                fontSize: 13.0,
                                fontFamily: appFont1,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "My Tasks",
                          style: TextStyle(
                            fontSize: 22.0,
                            fontFamily: appFont1,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            height: 33.0,
                            width: 33.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: addColor,
                            ),
                            child: Center(
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 22.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    HomeBody(
                      icon: Icons.timer,
                      color: todoColor,
                      title: "To Do",
                      sunTitle: "10 tasks now , 1 started",
                      onClick: () {},
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    HomeBody(
                      icon: Icons.timer,
                      color: onprogressColor,
                      title: "In Progress",
                      sunTitle: "1 task now , 1 started",
                      onClick: () {},
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    HomeBody(
                      icon: Icons.done,
                      color: doneColor,
                      title: "Done",
                      sunTitle: "18 tasks now , 13 started",
                      onClick: () {},
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Active Projects",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: appFont1,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
