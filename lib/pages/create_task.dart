import 'package:daily_planner/bloc_services/task_bloc/task_bloc.dart';
import 'package:daily_planner/bloc_services/task_bloc/task_events.dart';
import 'package:daily_planner/bloc_services/task_bloc/task_states.dart';
import 'package:daily_planner/components/appbar_widget.dart';
import 'package:daily_planner/components/auth_text_input.dart';
import 'package:daily_planner/components/categories_widget.dart';
import 'package:daily_planner/components/switch_pages.dart';
import 'package:daily_planner/components/time_text_field.dart';
import 'package:daily_planner/models/task_model.dart';
import 'package:daily_planner/pages/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:uuid/uuid.dart';

class CreateTask extends StatefulWidget {
  @override
  _CreateTaskState createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  final formKey = GlobalKey<FormState>();
  var color = Colors.grey;
  int coloredIndex = 0;
  bool isProgress = false;
  var type, task, date, lastTime, description, firstTime;
  var currentDate;
  @override
  void initState() {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    currentDate = formatter.format(now);
    date = currentDate;
    print(currentDate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var taskProvider = BlocProvider.of<TaskBloc>(context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppbarWidget.getAppBar("Create Task", context),
      body: ModalProgressHUD(
        inAsyncCall: isProgress,
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Container(
              height: size.height,
              width: size.width,
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 30.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      "Start time",
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        fontFamily: appFont1,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    TimeTextField(
                                      message: "start ...",
                                      icon: Icons.timer,
                                      onClick: (newvalue) {
                                        firstTime = newvalue;
                                      },
                                      onValidate: (value) {
                                        if (value.isEmpty) {
                                          return "this field is required";
                                        }
                                        return null;
                                      },
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "End time",
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        fontFamily: appFont1,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    TimeTextField(
                                      message: "End .....",
                                      icon: Icons.timer,
                                      onClick: (newvalue) {
                                        lastTime = newvalue;
                                      },
                                      onValidate: (value) {
                                        if (value.isEmpty) {
                                          return "this field is required";
                                        }
                                        return null;
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Form(
                              key: formKey,
                              child: Column(
                                children: [
                                  const SizedBox(height: 20.0),
                                  AuthTextInput(
                                    message: "Task ...",
                                    icon: Icons.add_task,
                                    onClick: (newValue) {
                                      task = newValue;
                                    },
                                    onValidate: (value) {
                                      if (value.isEmpty) {
                                        return "this field is required";
                                      }
                                      return null;
                                    },
                                    initialValue: "",
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  AuthTextInput(
                                    message: "date ...",
                                    icon: Icons.date_range,
                                    onClick: (newValue) {
                                      date = newValue;
                                    },
                                    onValidate: (value) {
                                      if (value.isEmpty) {
                                        return "this field is required";
                                      }
                                      return null;
                                    },
                                    initialValue: currentDate,
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  AuthTextInput(
                                    initialValue: "",
                                    message: "Description ...",
                                    icon: Icons.description,
                                    onClick: (newValue) {
                                      description = newValue;
                                    },
                                    onValidate: (value) {
                                      if (value.isEmpty) {
                                        return "this field is required";
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 25.0,
                            ),
                            Text(
                              "Categories",
                              style: TextStyle(
                                fontSize: 22.0,
                                fontFamily: appFont1,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Container(
                              width: 75.0,
                              height: 1.5,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                categoriesWidget(
                                  categoryName: "Study",
                                  index: 1,
                                  onClick: () {
                                    setState(() {
                                      color = Colors.red;
                                      coloredIndex = 1;
                                      type = "study";
                                    });
                                  },
                                  color: color,
                                  coloredIndex: coloredIndex,
                                ),
                                categoriesWidget(
                                  categoryName: "work",
                                  index: 2,
                                  onClick: () {
                                    setState(() {
                                      color = Colors.red;
                                      coloredIndex = 2;
                                      type = "work";
                                    });
                                  },
                                  color: color,
                                  coloredIndex: coloredIndex,
                                ),
                                categoriesWidget(
                                  categoryName: "personal",
                                  index: 3,
                                  onClick: () {
                                    setState(() {
                                      color = Colors.red;
                                      coloredIndex = 3;
                                      type = "personal";
                                    });
                                  },
                                  color: color,
                                  coloredIndex: coloredIndex,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 25.0,
                            ),
                            Center(
                              child: BlocListener<TaskBloc, TaskStates>(
                                listener: (context, state) {
                                  if (state is TaskAddedSucessState) {
                                    snackbarValidate(state.messsage, context);
                                    Navigator.of(context).pop();
                                  } else if (state is TaskAddedFailedState) {
                                    setState(() {
                                      isProgress = false;
                                    });
                                    snackbarValidate(state.error, context);
                                  }
                                },
                                child: BlocBuilder<TaskBloc, TaskStates>(
                                  builder: (context, state) {
                                    return Container(
                                      width: 190.0,
                                      height: 42.0,
                                      decoration: BoxDecoration(
                                        color: homeColor,
                                        borderRadius:
                                            BorderRadius.circular(40.0),
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            if (formKey.currentState!
                                                .validate()) {
                                              isProgress = true;
                                              var taskId = Uuid().v1();
                                              taskProvider.taskModel =
                                                  TaskModel(
                                                taskId: taskId,
                                                task: task,
                                                date: currentDate,
                                                description: description,
                                                category: type,
                                                firstTime: firstTime,
                                                lastTime: lastTime,
                                                isDone: false,
                                              );
                                              taskProvider
                                                  .add(CreateTaskEvent());
                                            }
                                          });
                                        },
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
                                    );
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                          ],
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
    );
  }
}
