import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_planner/bloc_services/task_bloc/task_bloc.dart';
import 'package:daily_planner/bloc_services/task_bloc/task_events.dart';
import 'package:daily_planner/bloc_services/task_bloc/task_states.dart';
import 'package:daily_planner/bloc_services/user_bloc/user_States.dart';
import 'package:daily_planner/bloc_services/user_bloc/user_bloc.dart';
import 'package:daily_planner/bloc_services/user_bloc/user_events.dart';
import 'package:daily_planner/components/activity_view.dart';
import 'package:daily_planner/components/home_body.dart';
import 'package:daily_planner/models/task_model.dart';
import 'package:daily_planner/pages/activities/activity_type.dart';
import 'package:daily_planner/pages/constants.dart';
import 'package:daily_planner/pages/create_task.dart';
import 'package:daily_planner/pages/search_page.dart';
import 'package:daily_planner/pages/settings.dart';
import 'package:daily_planner/pages/task_operations/archive_tasks.dart';
import 'package:daily_planner/pages/task_operations/done_tasks.dart';
import 'package:daily_planner/pages/task_operations/today_tasks.dart';
import 'package:daily_planner/pages/task_operations/todo_tasks.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    var userProvider = BlocProvider.of<UserBloc>(context);
    userProvider.model = FirebaseAuth.instance.currentUser!.uid;
    userProvider.add(FetchSpecialUserEvent());
    var taskProvider = BlocProvider.of<TaskBloc>(context);
    taskProvider.add(ShowCurrentTasksEvent());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: SafeArea(
          child: Column(
            children: [
              _header(size),
              SizedBox(
                height: 5.0,
              ),
              _body(size),
              _footer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header(var size) {
    return Container(
      height: 150.0,
      width: double.infinity,
      decoration: BoxDecoration(
        color: homeColor,
      ),
      child: BlocBuilder<UserBloc, UserStates>(
        builder: (context, state) {
          var response;
          var result;
          var image, name;
          if (state is UserLoadingState) {
            return CircularProgressIndicator();
          } else if (state is UserLoadedState) {
            response = state.response;
          } else if (state is UserLoadingFailedState) {
            result = false;
          }
          return StreamBuilder<DocumentSnapshot>(
            stream: response,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                result = false;
                name = "UnKnown";
                image = "null";
              } else if (snapshot.hasData) {
                print("object");
                name = snapshot.data!["name"];
                image = snapshot.data!["image"];
              }
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hi, " + name,
                          style: TextStyle(
                            fontSize: 15.0,
                            fontFamily: appFont1,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => Settingpage(),
                                  ),
                                );
                              },
                              child: Icon(
                                Icons.settings,
                                size: 19.0,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 12.0,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => SearchPage(),
                                  ),
                                );
                              },
                              child: Icon(
                                Icons.search,
                                size: 19.0,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: borderColor,
                                  width: 1,
                                ),
                              ),
                              child: CircleAvatar(
                                radius: 10.0,
                                backgroundColor: homeColor,
                                child: result == false && image == "null"
                                    ? Image(
                                        height: 15.0,
                                        width: 15.0,
                                        image: AssetImage(
                                          userImage,
                                        ),
                                      )
                                    : ClipOval(
                                        child: CachedNetworkImage(
                                          height: 26.0,
                                          width: 26.0,
                                          fit: BoxFit.cover,
                                          imageUrl: image,
                                          placeholder: (context, url) =>
                                              CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              Image(
                                            image: AssetImage(userImage),
                                          ),
                                        ),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "today tasks",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontFamily: appFont1,
                            color: Colors.white,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => TodayTasks(),
                              ),
                            );
                          },
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(top: 5.0),
                            width: 30.0,
                            height: 21.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                color: Colors.white,
                                width: 0.6,
                              ),
                            ),
                            child: Icon(
                              Icons.arrow_right,
                              size: 22.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _body(var size) {
    return Expanded(
      flex: 3,
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
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
                  // dataLoadedError();
                }
                return StreamBuilder<QuerySnapshot>(
                  stream: result,
                  builder: (context, snapshot) {
                    int currentTasks = 0;
                    int doneTasks = 0;
                    if (snapshot.hasError) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasData) {
                      snapshot.data!.docs.forEach((DocumentSnapshot element) {
                        Map<String, dynamic> task =
                            element.data()! as Map<String, dynamic>;
                        TaskModel model = TaskModel.fromJson(task);
                        if (model.isDone == true) {
                          doneTasks++;
                        } else if (model.isDone == false) {
                          currentTasks++;
                        }
                      });
                    }
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "My Tasks",
                              style: TextStyle(
                                fontSize: 19.0,
                                fontFamily: appFont1,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => CreateTask(),
                                  ),
                                );
                              },
                              child: Container(
                                height: 22.0,
                                width: 22.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: addColor,
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 17.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        HomeBody(
                          icon: Icons.timer,
                          color: todoColor,
                          title: "To Do",
                          sunTitle: "$currentTasks tasks now ",
                          onClick: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ToDoTasks(),
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: 23.0,
                        ),
                        HomeBody(
                          icon: Icons.delete,
                          color: onprogressColor,
                          title: "Archive",
                          sunTitle: "some tasks here",
                          onClick: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ArchiveTasks(),
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: 23.0,
                        ),
                        HomeBody(
                          icon: Icons.done,
                          color: doneColor,
                          title: "Done",
                          sunTitle: "$doneTasks tasks now ",
                          onClick: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => DoneTasks(),
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _footer() {
    return Expanded(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
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
                  // dataLoadedError();
                }
                return StreamBuilder<QuerySnapshot>(
                  stream: result,
                  builder: (context, snapshot) {
                    int studyTasks = 0;
                    int workTasks = 0;
                    int personalTasks = 0;
                    int doneStudyTasks = 0;
                    int doneWorkTasks = 0;
                    int donePersonalTasks = 0;
                    double doneStudyPercent = 0.0;
                    double doneWorkPercent = 0.0;
                    double donePersonalPercent = 0.0;
                    if (snapshot.hasError) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasData) {
                      snapshot.data!.docs.forEach((DocumentSnapshot element) {
                        Map<String, dynamic> task =
                            element.data()! as Map<String, dynamic>;
                        TaskModel model = TaskModel.fromJson(task);
                        if (model.category == "study") {
                          studyTasks++;
                          if (model.isDone == true) {
                            doneStudyTasks++;
                          }
                        } else if (model.category == "work") {
                          workTasks++;
                          if (model.isDone == true) {
                            doneWorkTasks++;
                          }
                        } else if (model.category == "personal") {
                          personalTasks++;
                          if (model.isDone == true) {
                            donePersonalTasks++;
                          }
                        }
                      });
                      if (doneStudyTasks / 10 < 1) {
                        doneStudyPercent = doneStudyTasks / 10 / 10;
                      } else {
                        doneStudyPercent = 1;
                      }
                      if (doneWorkTasks / 10 < 1) {
                        doneWorkPercent = doneWorkTasks / 10 / 10;
                      } else {
                        doneWorkPercent = 1;
                      }
                      if (donePersonalTasks / 10 < 1) {
                        donePersonalPercent = donePersonalTasks / 10 / 10;
                      } else {
                        donePersonalPercent = 1;
                      }
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Active Projects",
                            style: TextStyle(
                              fontSize: 17.0,
                              fontFamily: appFont1,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ActivityType(type: "study"),
                                    ),
                                  );
                                },
                                child: ActivityView(
                                  color: Colors.blue,
                                  title: "Study",
                                  desciption: "desciption",
                                  rating: studyTasks,
                                  percent: doneStudyPercent,
                                ),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ActivityType(type: "work"),
                                    ),
                                  );
                                },
                                child: ActivityView(
                                  color: Colors.orange,
                                  title: "Work",
                                  desciption: "desciption",
                                  rating: workTasks,
                                  percent: doneWorkPercent,
                                ),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ActivityType(type: "personal"),
                                    ),
                                  );
                                },
                                child: ActivityView(
                                  color: Colors.deepOrange[300],
                                  title: "Personal",
                                  desciption: "desciption",
                                  rating: personalTasks,
                                  percent: donePersonalPercent,
                                ),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
