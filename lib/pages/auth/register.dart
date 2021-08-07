import 'package:daily_planner/bloc_services/auth_bloc/auth_Events.dart';
import 'package:daily_planner/bloc_services/auth_bloc/auth_bloc.dart';
import 'package:daily_planner/bloc_services/auth_bloc/auth_states.dart';
import 'package:daily_planner/components/auth_text_input.dart';
import 'package:daily_planner/components/button_action.dart';
import 'package:daily_planner/models/user_model.dart';
import 'package:daily_planner/pages/auth/login.dart';
import 'package:daily_planner/pages/constants.dart';
import 'package:daily_planner/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:modal_progress_hud/modal_progress_hud.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var formKey = GlobalKey<FormState>();
  var name;
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
          padding: const EdgeInsets.only(
            left: 10.0,
            right: 10.0,
          ),
          child: SafeArea(
            top: false,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.height * 0.1,
                  ),
                  Text(
                    "Register",
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
                    "Create your new account",
                    style: TextStyle(
                      fontSize: 13.0,
                      fontFamily: appFont1,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.1,
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        AuthTextInput(
                          message: "Name",
                          icon: Icons.person,
                          onClick: (newValue) {
                            name = newValue;
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
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.06,
                  ),
                  Center(
                    child: BlocListener<AuthBloc, AuthStates>(
                      listener: (context, state) {
                        if (state is RegisterSucessState) {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (c) => Home(),
                            ),
                          );
                        } else if (state is RegisterFailedState) {
                          setState(() {
                            isProgressed = false;
                          });
                          snackbarValidate(state.message, context);
                        }
                      },
                      child: BlocBuilder<AuthBloc, AuthStates>(
                        builder: (context, state) {
                          return ButtonAction(
                            title: "Register",
                            onClick: () {
                              setState(
                                () {
                                  if (formKey.currentState!.validate()) {
                                    isProgressed = true;
                                    provider.model = UserModel(
                                      name: name,
                                      email: email,
                                      password: password,
                                      image: "null",
                                    );
                                    provider.add(RegisterEvent());
                                    print("register");
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
                            "Do you have an account?",
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
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (c) => Login(),
                                ),
                              );
                            },
                            child: Text(
                              "Login",
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
}
