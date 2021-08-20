import 'package:daily_planner/bloc_services/task_bloc/task_bloc.dart';
import 'package:daily_planner/bloc_services/user_bloc/user_bloc.dart';
import 'package:daily_planner/database/firebase/auth_operations.dart';
import 'package:daily_planner/database/firebase/task_operations.dart';
import 'package:daily_planner/database/firebase/user_operations.dart';
import 'package:daily_planner/pages/constants.dart';
import 'package:daily_planner/pages/home.dart';
import 'package:daily_planner/pages/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'bloc_services/auth_bloc/auth_bloc.dart';

main(List<String> args) async {
  WidgetsFlutterBinding
      .ensureInitialized(); // is used to interact with firebase engine >>
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: homeColor,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    return MultiProvider(
      providers: [
        // Auth Bloc
        BlocProvider<AuthBloc>(
          create: (context) {
            return AuthBloc(
              repostory: AuthOperations(),
            );
          },
        ),
        // User Bloc
        BlocProvider<UserBloc>(
          create: (context) {
            return UserBloc(
              repositoryModel: UserOperations(),
            );
          },
        ),
        // task Bloc
        BlocProvider<TaskBloc>(
          create: (context) {
            return TaskBloc(
              repositoryModel: TaskOperations(),
            );
          },
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AuthOperations().checkCurrentUser() == false
            ? SplashScreen()
            : Home(),
      ),
    );
  }
}
