import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_planner/bloc_services/auth_bloc/auth_Events.dart';
import 'package:daily_planner/bloc_services/auth_bloc/auth_bloc.dart';
import 'package:daily_planner/bloc_services/auth_bloc/auth_states.dart';
import 'package:daily_planner/bloc_services/user_bloc/user_States.dart';
import 'package:daily_planner/bloc_services/user_bloc/user_bloc.dart';
import 'package:daily_planner/bloc_services/user_bloc/user_events.dart';
import 'package:daily_planner/components/Settings_comp_view.dart';
import 'package:daily_planner/components/appbar_widget.dart';
import 'package:daily_planner/components/switch_pages.dart';
import 'package:daily_planner/pages/activities/activity_type.dart';
import 'package:daily_planner/pages/constants.dart';
import 'package:daily_planner/pages/home.dart';
import 'package:daily_planner/pages/setting_components/change_password.dart';
import 'package:daily_planner/pages/setting_components/edit_profile.dart';
import 'package:daily_planner/pages/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Settingpage extends StatefulWidget {
  @override
  _SettingpageState createState() => _SettingpageState();
}

class _SettingpageState extends State<Settingpage> {
  var name, email, image;

  @override
  Widget build(BuildContext context) {
    var authProvider = BlocProvider.of<AuthBloc>(context);
    var userProvider = BlocProvider.of<UserBloc>(context);
    userProvider.model = FirebaseAuth.instance.currentUser!.uid;
    userProvider.add(FetchSpecialUserEvent());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppbarWidget.getAppBar("Settings", context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 10.0,
            right: 10.0,
          ),
          child: ListView(
            children: [
              SizedBox(
                height: 17.0,
              ),
              BlocBuilder<UserBloc, UserStates>(
                builder: (context, state) {
                  var response;
                  var result;
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
                        email = "UnKnown";
                        image = "null";
                      } else if (snapshot.hasData) {
                        print("object");
                        name = snapshot.data!["name"];
                        email = snapshot.data!["email"];
                        image = snapshot.data!["image"];
                      }
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 20),
                          Container(
                            height: 65.0,
                            width: 70.0,
                            decoration: BoxDecoration(
                              color: Colors.blue[50],
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: CircleAvatar(
                                backgroundColor: Colors.grey[200],
                                radius: 21.0,
                                child: result == false && image == "null"
                                    ? Image(
                                        image: AssetImage(userImage),
                                      )
                                    : ClipOval(
                                        child: CachedNetworkImage(
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
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            name,
                            style: TextStyle(
                              fontSize: 13.0,
                              fontFamily: appFont1,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 3.0,
                          ),
                          Text(
                            "User",
                            style: TextStyle(
                              fontSize: 10.0,
                              fontFamily: appFont1,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                "Profile",
                style: TextStyle(
                  fontSize: 10.0,
                  fontFamily: appFont1,
                  color: Colors.grey[400],
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              SettingComponentsView(
                onClick: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => EditProfile(
                        name: name,
                        email: email,
                        image: image,
                        id: userProvider.model,
                      ),
                    ),
                  );
                },
                hint: "Edit profile",
                icon: editImage,
                color: Colors.red,
              ),
              SizedBox(
                height: 10.0,
              ),
              SettingComponentsView(
                onClick: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ChangePassword(),
                    ),
                  );
                },
                hint: "Change Password",
                icon: changePassword,
                color: Colors.blue,
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "App",
                style: TextStyle(
                  fontSize: 10.0,
                  fontFamily: appFont1,
                  color: Colors.grey[400],
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              SettingComponentsView(
                onClick: () {
                  shared("Daily Planner App", context);
                },
                hint: "Share App",
                icon: shareAppImage,
                color: Colors.orange,
              ),
              SizedBox(
                height: 10.0,
              ),
              SettingComponentsView(
                onClick: () {
                  launchUrl();
                },
                hint: "Rate App",
                icon: rateAppImage,
                color: doneColor,
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "Others",
                style: TextStyle(
                  fontSize: 10.0,
                  fontFamily: appFont1,
                  color: Colors.grey[400],
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              SettingComponentsView(
                onClick: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(
                          "Choose activty type",
                          style: TextStyle(
                            fontSize: 15.0,
                            fontFamily: appFont1,
                            color: Colors.black,
                          ),
                        ),
                        actions: [
                          Center(
                            child: Container(
                              width: 130.0,
                              height: 38.0,
                              decoration: BoxDecoration(
                                color: homeColor,
                                borderRadius: BorderRadius.circular(40.0),
                              ),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ActivityType(type: "study"),
                                    ),
                                  );
                                },
                                child: Center(
                                  child: Text(
                                    "study",
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
                          const SizedBox(height: 10.0),
                          Center(
                            child: Container(
                              width: 130.0,
                              height: 38.0,
                              decoration: BoxDecoration(
                                color: homeColor,
                                borderRadius: BorderRadius.circular(40.0),
                              ),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ActivityType(type: "work"),
                                    ),
                                  );
                                },
                                child: Center(
                                  child: Text(
                                    "work",
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
                          const SizedBox(height: 10.0),
                          Center(
                            child: Container(
                              width: 130.0,
                              height: 38.0,
                              decoration: BoxDecoration(
                                color: homeColor,
                                borderRadius: BorderRadius.circular(40.0),
                              ),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ActivityType(type: "personal"),
                                    ),
                                  );
                                },
                                child: Center(
                                  child: Text(
                                    "personal",
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
                      );
                    },
                  );
                },
                hint: "Activities",
                icon: logoutImage,
                color: Colors.purple,
              ),
              SizedBox(
                height: 10.0,
              ),
              BlocListener<AuthBloc, AuthStates>(
                listener: (context, state) {
                  if (state is LogOutSucessState) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => SplashScreen(),
                      ),
                    );
                  } else if (state is LogOutFailedState) {
                    snackbarValidate(state.message, context);
                  }
                },
                child: BlocBuilder<AuthBloc, AuthStates>(
                  builder: (context, state) {
                    return SettingComponentsView(
                      onClick: () {
                        authProvider.add(LogOutEvent());
                      },
                      hint: "LogOut",
                      icon: logoutImage,
                      color: Colors.purple,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
