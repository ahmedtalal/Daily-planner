import 'package:daily_planner/components/auth_text_input.dart';
import 'package:daily_planner/components/switch_pages.dart';
import 'package:daily_planner/components/time_text_field.dart';
import 'package:daily_planner/pages/constants.dart';
import 'package:flutter/material.dart';

class CreateTask extends StatefulWidget {
  @override
  _CreateTaskState createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  final formKey = GlobalKey<FormState>();

  var color = Colors.grey;
  int coloredIndex = 0;
  var type;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: false,
        child: Container(
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: homeColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: size.height * 0.08,
                      ),
                      Row(
                        children: [
                          SwitchPages(
                            title: "task",
                            onClick: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          Text(
                            "Create New Task",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: appFont1,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 18.0,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "Start time",
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontFamily: appFont1,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  TimeTextField(
                                    message: "start",
                                    icon: Icons.timer,
                                    onClick: (newvalue) {},
                                    onValidate: (value) {},
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    "End time",
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontFamily: appFont1,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  TimeTextField(
                                    message: "End",
                                    icon: Icons.timer,
                                    onClick: (newvalue) {},
                                    onValidate: (value) {},
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 16.0,
                          ),
                          Form(
                            key: formKey,
                            child: Column(
                              children: [
                                AuthTextInput(
                                  message: "Task ...",
                                  icon: Icons.add_task,
                                  onClick: (newValue) {},
                                  onValidate: (value) {},
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                AuthTextInput(
                                  message: "date ...",
                                  icon: Icons.date_range,
                                  onClick: (newValue) {},
                                  onValidate: (value) {},
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                AuthTextInput(
                                  message: "Description ...",
                                  icon: Icons.description,
                                  onClick: (newValue) {},
                                  onValidate: (value) {},
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 9.0,
                          ),
                          Text(
                            "Categories",
                            style: TextStyle(
                              fontSize: 23.0,
                              fontFamily: appFont1,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 4.0,
                          ),
                          Container(
                            width: 75.0,
                            height: 2.3,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              categories("sports", 1),
                              categories("work", 2),
                              categories("personal", 3),
                            ],
                          ),
                          SizedBox(
                            height: 26.0,
                          ),
                          Center(
                            child: Container(
                              width: 190.0,
                              height: 42.0,
                              decoration: BoxDecoration(
                                color: homeColor,
                                borderRadius: BorderRadius.circular(40.0),
                              ),
                              child: InkWell(
                                onTap: () {},
                                child: Center(
                                  child: Text(
                                    "Create Task",
                                    style: TextStyle(
                                      fontFamily: appFont1,
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget categories(String category, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          color = Colors.red;
          coloredIndex = index;
          type = category;
        });
      },
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(bottom: 5.0),
        height: 35.0,
        width: 105.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40.0),
          color: coloredIndex == index ? color : Colors.grey,
        ),
        child: Text(
          category,
          style: TextStyle(
            fontSize: 17.0,
            fontFamily: appFont1,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
