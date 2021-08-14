import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_planner/bloc_services/task_bloc/task_bloc.dart';
import 'package:daily_planner/bloc_services/task_bloc/task_events.dart';
import 'package:daily_planner/bloc_services/task_bloc/task_states.dart';
import 'package:daily_planner/components/appbar_widget.dart';
import 'package:daily_planner/components/data_loaded_error.dart';
import 'package:daily_planner/components/task_view_archive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArchiveTasks extends StatefulWidget {
  @override
  _ArchiveTasksState createState() => _ArchiveTasksState();
}

class _ArchiveTasksState extends State<ArchiveTasks> {
  @override
  Widget build(BuildContext context) {
    var taskProvider = BlocProvider.of<TaskBloc>(context);
    taskProvider.add(ShowArchiveTasksEvent());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppbarWidget.getAppBar("Archive Tasks", context),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 16,
          ),
          child: BlocBuilder<TaskBloc, TaskStates>(
            builder: (context, state) {
              var result;
              if (state is ArchiveTaskLoadingState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is ArchiveTaskLoadedState) {
                result = state.response;
              } else if (state is ArchiveTaskFailedLoadingState) {
                dataLoadedError();
              }
              return StreamBuilder<QuerySnapshot>(
                stream: result,
                builder: (context, snapshot) {
                  List archiveTasks = [];
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    archiveTasks.clear();
                    snapshot.data!.docs.forEach((DocumentSnapshot element) {
                      archiveTasks.add(element.data()!);
                    });
                  }
                  if (archiveTasks.isEmpty) {
                    return dataLoadedError();
                  } else {
                    return ListView.builder(
                      itemCount: archiveTasks.length,
                      itemBuilder: (context, index) {
                        return TaskViewArchive(
                          taskModel: archiveTasks[index],
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
