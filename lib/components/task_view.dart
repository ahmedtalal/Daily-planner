import 'package:daily_planner/pages/constants.dart';
import 'package:daily_planner/pages/task_operations/task_Details.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class TaskView extends StatelessWidget {
  var taskModel;
  TaskView({
    required this.taskModel,
  });
  var currentDate;
  late String status;
  _getDate() {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    currentDate = formatter.format(now);
    print(currentDate);
  }

  @override
  Widget build(BuildContext context) {
    _getDate();
    _checkStatus();
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => TaskDetails(data: taskModel),
          ),
        );
      },
      child: Card(
        elevation: 3.0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Task Name : ",
                    style: TextStyle(
                      fontSize: 15.0,
                      fontFamily: appFont1,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    taskModel["task"],
                    style: TextStyle(
                      fontSize: 14.0,
                      fontFamily: appFont1,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 2.0,
              ),
              Row(
                children: [
                  Text(
                    "Period: ",
                    style: TextStyle(
                      fontSize: 15.0,
                      fontFamily: appFont1,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    "${taskModel["firstTime"]} to ${taskModel["lastTime"]}",
                    style: TextStyle(
                      fontSize: 14.0,
                      fontFamily: appFont1,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 2.0,
              ),
              Row(
                children: [
                  Text(
                    "Type : ",
                    style: TextStyle(
                      fontSize: 15.0,
                      fontFamily: appFont1,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    taskModel["category"],
                    style: TextStyle(
                      fontSize: 14.0,
                      fontFamily: appFont1,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                child: Align(
                  alignment: Alignment.topRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        status,
                        style: TextStyle(
                          fontSize: 12.0,
                          fontFamily: appFont1,
                          color: Colors.teal,
                        ),
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      Icon(
                        taskModel["isDone"] == false
                            ? Icons.cancel
                            : Icons.check_circle,
                        size: 18.0,
                        color: Colors.teal,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _checkStatus() {
    if (currentDate == taskModel["date"]) {
      status = "today";
    } else if (taskModel["isDone"] == true) {
      status = taskModel["date"];
    } else {
      status = "delayed";
    }
  }
}
