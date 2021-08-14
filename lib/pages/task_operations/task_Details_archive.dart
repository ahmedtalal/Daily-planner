import 'package:daily_planner/bloc_services/task_bloc/task_bloc.dart';
import 'package:daily_planner/bloc_services/task_bloc/task_events.dart';
import 'package:daily_planner/bloc_services/task_bloc/task_states.dart';
import 'package:daily_planner/components/appbar_widget.dart';
import 'package:daily_planner/components/categories_widget.dart';
import 'package:daily_planner/models/task_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../constants.dart';

// ignore: must_be_immutable
class TaskDetailsArchive extends StatefulWidget {
  var data;
  TaskDetailsArchive({
    required this.data,
  });
  @override
  _TaskDetailsArchiveState createState() => _TaskDetailsArchiveState();
}

class _TaskDetailsArchiveState extends State<TaskDetailsArchive> {
  var formKey = GlobalKey<FormState>();
  TextEditingController taskController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  var color = Colors.grey;
  int coloredIndex = 0;
  var type, task, date, lastTime, description, firstTime;
  bool isProgressed = false;

  @override
  void initState() {
    taskController.text = widget.data["task"];
    dateController.text = widget.data["date"];
    startTimeController.text = widget.data["firstTime"];
    endTimeController.text = widget.data["lastTime"];
    descriptionController.text = widget.data["description"];
    type = widget.data["category"];
    if (widget.data["category"] == "personal") {
      coloredIndex = 3;
      color = Colors.red;
    } else if (widget.data["category"] == "work") {
      coloredIndex = 2;
      color = Colors.red;
    } else {
      coloredIndex = 1;
      color = Colors.red;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var taskProvider = BlocProvider.of<TaskBloc>(context);

    return Scaffold(
      appBar: AppbarWidget.getAppBar("Task Details", context),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 5.0,
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 22.0,
                ),
                _editTextField(
                  textController: taskController,
                  onClick: (newValue) {
                    task = newValue;
                  },
                  onValidate: (value) {
                    if (value.isEmpty) {
                      return "this field is required";
                    }
                    return null;
                  },
                  message: "task",
                  icon: Icons.add_task,
                ),
                SizedBox(
                  height: 15.0,
                ),
                _editTextField(
                  textController: descriptionController,
                  onClick: (newValue) {
                    description = newValue;
                  },
                  onValidate: (value) {
                    if (value.isEmpty) {
                      return "this field is required";
                    }
                    return null;
                  },
                  message: "description",
                  icon: Icons.description,
                ),
                SizedBox(
                  height: 15.0,
                ),
                _editTextField(
                  textController: dateController,
                  onClick: (newValue) {
                    date = newValue;
                  },
                  onValidate: (value) {
                    if (value.isEmpty) {
                      return "this field is required";
                    }
                    return null;
                  },
                  message: "Date",
                  icon: Icons.date_range,
                ),
                SizedBox(
                  height: 15.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        child: _editTextField(
                          textController: startTimeController,
                          onClick: (newValue) {
                            firstTime = newValue;
                          },
                          onValidate: (value) {
                            if (value.isEmpty) {
                              return "this field is required";
                            }
                            return null;
                          },
                          message: "start time",
                          icon: Icons.timer,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 13.0,
                    ),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        child: _editTextField(
                          textController: endTimeController,
                          onClick: (newValue) {
                            lastTime = newValue;
                          },
                          onValidate: (value) {
                            if (value.isEmpty) {
                              return "this field is required";
                            }
                            return null;
                          },
                          message: "end time",
                          icon: Icons.timer,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 22.0,
                ),
                Text(
                  "Categories : ",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontFamily: appFont1,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 22.0,
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
                  height: 28.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: BlocListener<TaskBloc, TaskStates>(
                        listener: (context, state) {
                          if (state is ModifyTaskSuccessState) {
                            //Navigator.of(context).pop();
                            setState(() {
                              snackbarValidate(state.mesage, context);
                              isProgressed = false;
                            });
                          } else if (state is ModifyTaskFailedState) {
                            snackbarValidate(state.error, context);
                          }
                        },
                        child: Center(
                          child: BlocBuilder<TaskBloc, TaskStates>(
                            builder: (context, state) {
                              return _taskButton(
                                "Reuse",
                                () {
                                  setState(() {
                                    if (formKey.currentState!.validate()) {
                                      taskProvider.taskModel = TaskModel(
                                        taskId: widget.data["taskId"],
                                        task: taskController.text,
                                        date: dateController.text,
                                        description: descriptionController.text,
                                        category: type,
                                        firstTime: startTimeController.text,
                                        lastTime: endTimeController.text,
                                        isDone: false,
                                      );
                                      taskProvider.add(UpdateTaskEvent());
                                      isProgressed = true;
                                    }
                                  });
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: _taskButton(
                        "Delete",
                        () {
                          setState(() {
                            if (formKey.currentState!.validate()) {
                              taskProvider.taskId = widget.data["taskId"];
                              isProgressed = true;
                              taskProvider.add(DeleteArchiveTaskEvent());
                            }
                          });
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8.0,
                ),
                Center(
                  child: Visibility(
                    visible: isProgressed,
                    child: Container(
                      height: 25.0,
                      width: 25.0,
                      child: CircularProgressIndicator(
                        color: homeColor,
                        strokeWidth: 2.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _editTextField({
    required var textController,
    required var onClick,
    required var onValidate,
    required var message,
    required var icon,
  }) {
    return Container(
      height: message != "description" ? 50.0 : null,
      child: TextFormField(
        maxLines: message == "description" ? 3 : 1,
        controller: textController,
        onChanged: onClick,
        validator: onValidate,
        style: TextStyle(
          fontSize: 14.0,
          fontFamily: appFont1,
          fontWeight: FontWeight.bold,
        ),
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
        keyboardType: TextInputType.text,
      ),
    );
  }

  Widget _taskButton(String title, var onClick) {
    return Container(
      width: 180.0,
      height: 40.0,
      decoration: BoxDecoration(
        color: homeColor,
        borderRadius: BorderRadius.circular(40.0),
      ),
      child: InkWell(
        onTap: onClick,
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontFamily: appFont1,
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
