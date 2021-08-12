import 'package:daily_planner/bloc_services/auth_bloc/auth_Events.dart';
import 'package:daily_planner/bloc_services/auth_bloc/auth_bloc.dart';
import 'package:daily_planner/bloc_services/auth_bloc/auth_states.dart';
import 'package:daily_planner/components/appbar_widget.dart';
import 'package:daily_planner/components/auth_text_input.dart';
import 'package:daily_planner/components/switch_pages.dart';
import 'package:daily_planner/pages/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  var newPassword;
  bool isProgressed = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var authProvider = BlocProvider.of<AuthBloc>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppbarWidget.getAppBar("Change Password", context),
      body: ModalProgressHUD(
        inAsyncCall: isProgressed,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 15.0,
                ),
                Form(
                  child: Column(
                    children: [
                      Container(
                        width: size.width * 0.8,
                        height: size.height * 0.073,
                        child: AuthTextInput(
                          initialValue: "",
                          message: "new password",
                          icon: Icons.lock,
                          onClick: (newValue) {
                            newPassword = newValue;
                          },
                          onValidate: (value) {
                            if (value.isEmpty) {
                              return "this field is required";
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                ),
                BlocListener<AuthBloc, AuthStates>(
                  listener: (context, state) {
                    if (state is UpdatePassSucessState) {
                      snackbarValidate(state.message, context);
                    } else if (state is UpdatePassFailedState) {
                      snackbarValidate(state.error, context);
                    }
                  },
                  child: BlocBuilder<AuthBloc, AuthStates>(
                    builder: (context, state) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            isProgressed = true;
                          });
                          print(newPassword);
                          authProvider.model = newPassword;
                          authProvider.add(UpdatePasswordEvent());
                        },
                        child: Container(
                          width: size.width * 0.7,
                          height: size.height * 0.076,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromRGBO(143, 148, 251, 1),
                                Color.fromRGBO(143, 148, 251, .6),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Center(
                            child: Text(
                              "Update",
                              style: TextStyle(
                                fontSize: 14.0,
                                fontFamily: appFont1,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
