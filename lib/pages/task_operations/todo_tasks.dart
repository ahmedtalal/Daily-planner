import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_planner/bloc_services/task_bloc/task_bloc.dart';
import 'package:daily_planner/bloc_services/task_bloc/task_events.dart';
import 'package:daily_planner/bloc_services/task_bloc/task_states.dart';
import 'package:daily_planner/components/appbar_widget.dart';
import 'package:daily_planner/components/data_loaded_error.dart';
import 'package:daily_planner/components/task_view.dart';
import 'package:daily_planner/models/task_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ToDoTasks extends StatefulWidget {
  @override
  _ToDoTasksState createState() => _ToDoTasksState();
}

class _ToDoTasksState extends State<ToDoTasks> {
  @override
  Widget build(BuildContext context) {
    var taskProvider = BlocProvider.of<TaskBloc>(context);
    taskProvider.add(ShowCurrentTasksEvent());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppbarWidget.getAppBar("Current Tasks", context),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: BlocBuilder<TaskBloc, TaskStates>(
            builder: (context, state) {
              var result;
              if (state is CurrentTaskLoadingState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is CurrentTaskLoadedState) {
                result = state.response;
              } else if (state is CurrentTaskFailedLoadingState) {
                dataLoadedError();
              }
              return StreamBuilder<QuerySnapshot>(
                stream: result,
                builder: (context, snapshot) {
                  List currentTasks = [];
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    currentTasks.clear();
                    snapshot.data!.docs.forEach((DocumentSnapshot element) {
                      Map<String, dynamic> task =
                          element.data()! as Map<String, dynamic>;
                      TaskModel model = TaskModel.fromJson(task);
                      if (model.isDone == false) {
                        currentTasks.add(element.data()!);
                      }
                    });
                  }
                  if (currentTasks.isEmpty) {
                    return dataLoadedError();
                  } else {
                    return ListView.builder(
                      itemCount: currentTasks.length,
                      itemBuilder: (context, index) {
                        return TaskView(
                          taskModel: currentTasks[index],
                        );
                      },
                    );
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
