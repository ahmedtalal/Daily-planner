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

// ignore: must_be_immutable
class ActivityType extends StatefulWidget {
  late String type;

  ActivityType({
    required this.type,
  });
  @override
  _ActivityTypeState createState() => _ActivityTypeState();
}

class _ActivityTypeState extends State<ActivityType> {
  @override
  Widget build(BuildContext context) {
    var taskProvider = BlocProvider.of<TaskBloc>(context);
    taskProvider.add(ShowCurrentTasksEvent());
    return Scaffold(
      appBar: AppbarWidget.getAppBar(widget.type + " activty", context),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.all(10.0),
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
                  List tasks = [];
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    tasks.clear();
                    snapshot.data!.docs.forEach((DocumentSnapshot element) {
                      Map<String, dynamic> task =
                          element.data()! as Map<String, dynamic>;
                      TaskModel model = TaskModel.fromJson(task);
                      if (model.category == widget.type) {
                        tasks.add(element.data()!);
                      }
                    });
                  }
                  if (tasks.isEmpty) {
                    return dataLoadedError();
                  } else {
                    return ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        return TaskView(
                          taskModel: tasks[index],
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
