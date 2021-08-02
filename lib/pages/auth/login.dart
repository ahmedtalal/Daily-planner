import 'package:daily_planner/bloc_services/auth_bloc/auth_Events.dart';
import 'package:daily_planner/bloc_services/auth_bloc/auth_bloc.dart';
import 'package:daily_planner/bloc_services/auth_bloc/auth_states.dart';
import 'package:daily_planner/components/auth_text_input.dart';
import 'package:daily_planner/components/button_action.dart';
import 'package:daily_planner/models/user_model.dart';
import 'package:daily_planner/pages/constants.dart';
import 'package:daily_planner/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var formKey = GlobalKey<FormState>();
  var password;
  var email;

  bool isProgressed = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var provider = BlocProvider.of<AuthBloc>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: isProgressed,
        child: Padding(
          padding: EdgeInsets.only(
            left: 10.0,
            right: 10.0,
          ),
          child: SafeArea(
            top: false,
            child: SingleChildScrollView(
              child: Column(
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
                              onTap: () {},
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
                    height: size.height * 0.02,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Text(
                            "Do not have an account?",
                            style: TextStyle(
                              fontSize: 16.0,
                              fontFamily: appFont1,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              "Register",
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: appFont1,
                                color: Color.fromRGBO(143, 148, 251, 1),
                                decoration: TextDecoration.underline,
                                decorationStyle: TextDecorationStyle.solid,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void snackbarValidate(String s, BuildContext context) {
    setState(() {
      isProgressed = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          s,
        ),
      ),
    );
  }
}
