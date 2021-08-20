import 'package:daily_planner/bloc_services/auth_bloc/auth_Events.dart';
import 'package:daily_planner/bloc_services/auth_bloc/auth_bloc.dart';
import 'package:daily_planner/bloc_services/auth_bloc/auth_states.dart';
import 'package:daily_planner/components/auth_text_input.dart';
import 'package:daily_planner/components/button_action.dart';
import 'package:daily_planner/models/user_model.dart';
import 'package:daily_planner/pages/constants.dart';
import 'package:daily_planner/pages/home.dart';
import 'package:daily_planner/pages/setting_components/change_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

// ignore: must_be_immutable
class Login extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var password;
  var email;
  bool isProgressed = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var provider = BlocProvider.of<AuthBloc>(context);
    return StatefulBuilder(
      builder: (context, setState) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height * 0.1,
            ),
            Text(
              "Login",
              style: TextStyle(
                fontSize: 24.0,
                fontFamily: appFont1,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            SizedBox(
              height: 2.0,
            ),
            Text(
              "Nice to see you again",
              style: TextStyle(
                fontSize: 13.0,
                fontFamily: appFont1,
              ),
            ),
            SizedBox(
              height: size.height * 0.06,
            ),
            Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 15.0,
                  ),
                  AuthTextInput(
                    initialValue: "",
                    message: "Email",
                    icon: Icons.email,
                    onClick: (newValue) {
                      email = newValue;
                    },
                    onValidate: (value) {
                      if (value.isEmpty) {
                        return "this field is required";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  AuthTextInput(
                    initialValue: "",
                    message: "password",
                    icon: Icons.lock,
                    onClick: (newValue) {
                      password = newValue;
                    },
                    onValidate: (value) {
                      if (value.isEmpty) {
                        return "this field is required";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    width: size.width * 0.9,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ChangePassword(),
                            ),
                          );
                        },
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(
                            fontSize: 13.0,
                            fontFamily: appFont1,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.06,
            ),
            Center(
              child: BlocListener<AuthBloc, AuthStates>(
                listener: (context, state) {
                  if (state is LoginSucessState) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (c) => Home(),
                      ),
                    );
                  } else if (state is LoginFailedState) {
                    setState(() {
                      isProgressed = false;
                    });
                    snackbarValidate(state.message, context);
                  }
                },
                child: BlocBuilder<AuthBloc, AuthStates>(
                  builder: (context, state) {
                    return ButtonAction(
                      title: "Login",
                      onClick: () {
                        setState(
                          () {
                            if (formKey.currentState!.validate()) {
                              isProgressed = true;
                              provider.model = UserModel.login(
                                email: email,
                                password: password,
                              );
                              provider.add(LoginEvent());
                              print("login");
                            }
                          },
                        );
                      },
                      color: Colors.red[400],
                    );
                  },
                ),
              ),
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
        );
      },
    );
  }
}
