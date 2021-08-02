abstract class AuthStates {}

class InitialState extends AuthStates {}

class RegisterSucessState extends AuthStates {
  late String message;
  RegisterSucessState({
    required this.message,
  });
}

class RegisterFailedState extends AuthStates {
  late String message;
  RegisterFailedState({
    required this.message,
  });
}

class LoginSucessState extends AuthStates {}

class LoginFailedState extends AuthStates {
  var message;
  LoginFailedState({
    required this.message,
  });
}

class LogOutSucessState extends AuthStates {}

class LogOutFailedState extends AuthStates {
  var message;
  LogOutFailedState({
    required this.message,
  });
}
