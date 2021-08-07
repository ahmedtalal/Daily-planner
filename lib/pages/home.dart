import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_planner/bloc_services/user_bloc/user_States.dart';
import 'package:daily_planner/bloc_services/user_bloc/user_bloc.dart';
import 'package:daily_planner/bloc_services/user_bloc/user_events.dart';
import 'package:daily_planner/components/activity_view.dart';
import 'package:daily_planner/components/home_body.dart';
import 'package:daily_planner/pages/constants.dart';
import 'package:daily_planner/pages/create_task.dart';
import 'package:daily_planner/pages/search_page.dart';
import 'package:daily_planner/pages/settings.dart';
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
    return Expanded(
      child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: homeColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(35.0),
            bottomRight: Radius.circular(35.0),
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => Settingpage(),
                        ),
                      );
                    },
                    child: Image(
                      image: AssetImage(listIcon),
                      height: 20.0,
                      width: 20.0,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
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
                ],
              ),
            ),
            SizedBox(
              height: 13.0,
            ),
            Center(
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
                      return Row(
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
                              child: result == false && image == "null"
                                  ? Image(
                                      height: 40.0,
                                      width: 40.0,
                                      image: AssetImage(
                                        userImage,
                                      ),
                                    )
                                  : ClipOval(
                                      child: CachedNetworkImage(
                                        height: 40.0,
                                        width: 40.0,
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
                          Column(
                            children: [
                              Text(
                                name,
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
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _body(var size) {
    return Expanded(
      flex: 2,
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "My Tasks",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontFamily: appFont1,
                        fontWeight: FontWeight.bold,
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
                        height: 25.0,
                        width: 25.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: addColor,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 16.0,
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
                  icon: Icons.published_with_changes_outlined,
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
                  height: 25.0,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Active Projects",
                    style: TextStyle(
                      fontSize: 18.0,
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
      ),
    );
  }

  Widget _footer() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ActivityView(
                  color: Colors.blue,
                  title: "Sports",
                  desciption: "desciption",
                  rating: 20,
                  percent: 0.8,
                ),
                SizedBox(
                  width: 10.0,
                ),
                ActivityView(
                  color: Colors.orange,
                  title: "Work",
                  desciption: "desciption",
                  rating: 40,
                  percent: 0.7,
                ),
                SizedBox(
                  width: 10.0,
                ),
                ActivityView(
                  color: Colors.red,
                  title: "Travel",
                  desciption: "desciption",
                  rating: 30,
                  percent: 0.5,
                ),
                SizedBox(
                  width: 10.0,
                ),
                ActivityView(
                  color: Colors.deepOrange[300],
                  title: "Personal",
                  desciption: "desciption",
                  rating: 60,
                  percent: 0.3,
                ),
                SizedBox(
                  width: 10.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
