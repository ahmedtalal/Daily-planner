import 'package:daily_planner/bloc_services/auth_bloc/auth_states.dart';

abstract class UserStates {}

class InitialUserState extends UserStates {}

class UserLoadingState extends UserStates {}

class UserLoadedState extends UserStates {
  var response;
  UserLoadedState({
    required this.response,
  });
}

class UserLoadingFailedState extends UserStates {
  var error;
  UserLoadingFailedState({
    required this.error,
  });
}

class UserUpdateSucessState extends UserStates {
  var message;
  UserUpdateSucessState({
    required this.message,
  });
}

class UserUpdateFailedState extends UserStates {
  var error;
  UserUpdateFailedState({
    required this.error,
  });
}
