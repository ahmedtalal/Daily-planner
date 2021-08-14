import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_planner/bloc_services/task_bloc/task_bloc.dart';
import 'package:daily_planner/bloc_services/task_bloc/task_events.dart';
import 'package:daily_planner/bloc_services/task_bloc/task_states.dart';
import 'package:daily_planner/components/appbar_widget.dart';
import 'package:daily_planner/components/auth_text_input.dart';
import 'package:daily_planner/components/data_loaded_error.dart';
import 'package:daily_planner/components/task_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Map<String, dynamic>> allTasks = [];
  List<Map<String, dynamic>> fliterTasks = [];
  bool isConnected = true;
  @override
  Widget build(BuildContext context) {
    var taskProvider = BlocProvider.of<TaskBloc>(context);
    taskProvider.add(ShowCurrentTasksEvent());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppbarWidget.getAppBar("search", context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<TaskBloc, TaskStates>(
                builder: (context, state) {
                  var result;
                  if (state is CurrentTaskLoadingState) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is CurrentTaskLoadedState) {
                    result = state.response;
                  } else if (state is CurrentTaskFailedLoadingState) {
                    print("state false");
                    isConnected = false;
                  }
                  return StreamBuilder<QuerySnapshot>(
                    stream: result,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        print("stream false");
                        isConnected = false;
                      } else if (snapshot.hasData) {
                        print("done");
                        allTasks.clear();
                        snapshot.data!.docs.forEach((DocumentSnapshot element) {
                          allTasks.add(element.data()! as Map<String, dynamic>);
                        });
                        print(allTasks.length);
                      }
                      return AuthTextInput(
                        initialValue: "",
                        message: "Search",
                        icon: Icons.search,
                        onClick: (String newValue) {
                          setState(() {
                            fliterTasks.clear();
                            allTasks.forEach((Map<String, dynamic> taskModel) {
                              if (taskModel["task"]
                                  .toLowerCase()
                                  .contains(newValue.toLowerCase())) {
                                fliterTasks.add(taskModel);
                              }
                            });
                            if (newValue.isEmpty) {
                              fliterTasks.clear();
                            }
                          });
                        },
                        onValidate: (value) {},
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 7.0),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                    width: 100.0,
                    child: Divider(
                      color: Colors.grey,
                      thickness: 0.6,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              _fliterationTasks(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _fliterationTasks() {
    print("${fliterTasks.length} fliter");
    if (fliterTasks.isEmpty) {
      print("list empty");
      return Center(
        child: dataLoadedError(),
      );
    } else if (isConnected == false) {
      return Center(
        child: dataLoadedError(),
      );
    } else {
      return Expanded(
        child: ListView.builder(
          itemCount: fliterTasks.length,
          itemBuilder: (context, index) {
            return TaskView(taskModel: fliterTasks[index]);
          },
        ),
      );
    }
  }
}
