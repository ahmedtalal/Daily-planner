import 'package:daily_planner/bloc_services/auth_bloc/auth_Events.dart';
import 'package:daily_planner/bloc_services/auth_bloc/auth_states.dart';
import 'package:daily_planner/database/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvents, AuthStates> {
  AuthRepositoryModel repostory;
  var model;
  AuthBloc({
    required this.repostory,
  }) : super(InitialState());

  @override
  Stream<AuthStates> mapEventToState(AuthEvents event) async* {
    if (event is RegisterEvent) {
      try {
        var response = await repostory.register(model);
        if (response == true) {
          yield RegisterSucessState(message: "authentication sucessfull");
        } else {
          yield RegisterFailedState(message: "register unsucessfull");
        }
      } on FirebaseAuthException catch (e) {
        yield RegisterFailedState(
            message: e.code + " or No internet connection");
      } catch (e) {
        yield RegisterFailedState(
            message: e.toString() + 'An unknown error occured');
      }
    } else if (event is LoginEvent) {
      try {
        var response = await repostory.login(model);
        if (response != null) {
          yield LoginSucessState();
        } else {
          yield LoginFailedState(message: "login unsucessfull");
        }
      } on FirebaseAuthException catch (e) {
        yield LoginFailedState(message: e.code + " or No internet connection");
      } catch (e) {
        yield LoginFailedState(
            message: e.toString() + 'An unknown error occured');
      }
    } else if (event is LogOutEvent) {
      try {
        await repostory.logOut();
        yield LogOutSucessState();
      } catch (e) {
        yield LogOutFailedState(message: "lgout unscussefull");
      }
    }
  }
}
