import 'package:cached_network_image/cached_network_image.dart';
import 'package:daily_planner/bloc_services/auth_bloc/auth_Events.dart';
import 'package:daily_planner/bloc_services/auth_bloc/auth_bloc.dart';
import 'package:daily_planner/bloc_services/auth_bloc/auth_states.dart';
import 'package:daily_planner/components/Settings_comp_view.dart';
import 'package:daily_planner/pages/constants.dart';
import 'package:daily_planner/pages/home.dart';
import 'package:daily_planner/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    var height = MediaQuery.of(context).size.height;
    var authProvider = BlocProvider.of<AuthBloc>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 12.0,
            right: 10.0,
          ),
          child: ListView(
            children: [
              SizedBox(
                height: height * 0.04,
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => Home(),
                      ),
                    ),
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 20.0,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "Settings",
                    style: TextStyle(
                      fontSize: 14.0,
                      fontFamily: appFont1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.05,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 70.0,
                    width: 75.0,
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        backgroundColor: Colors.grey[200],
                        radius: 25.0,
                        child: ClipOval(
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: userImage,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) => Image(
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
                    "Ahmed Talal",
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
                onClick: () {},
                hint: "Edit profile",
                icon: editImage,
                color: Colors.red,
              ),
              SizedBox(
                height: 10.0,
              ),
              SettingComponentsView(
                onClick: () {},
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
                onClick: () {},
                hint: "Share App",
                icon: shareAppImage,
                color: Colors.orange,
              ),
              SizedBox(
                height: 10.0,
              ),
              SettingComponentsView(
                onClick: () {},
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
                onClick: () {},
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

  void snackbarValidate(String s, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          s,
        ),
      ),
    );
  }
}
