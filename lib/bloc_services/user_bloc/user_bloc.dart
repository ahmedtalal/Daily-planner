import 'package:daily_planner/bloc_services/user_bloc/user_States.dart';
import 'package:daily_planner/bloc_services/user_bloc/user_events.dart';
import 'package:daily_planner/database/repository/db_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvents, UserStates> {
  FirebaseRepositoryModel repositoryModel;
  var model;
  var model1;
  UserBloc({
    required this.repositoryModel,
  }) : super(InitialUserState());

  @override
  Stream<UserStates> mapEventToState(UserEvents event) async* {
    if (event is FetchSpecialUserEvent) {
      yield UserLoadingState();
      try {
        var result = repositoryModel.getSpecialData(model);
        yield UserLoadedState(response: result);
      } catch (e) {
        yield UserLoadingFailedState(error: e.toString());
      }
    } else if (event is UserUpdateEvent) {
      try {
        var response = await repositoryModel.updateData(model1);
        if (response == true) {
          yield UserUpdateSucessState(message: "update successfully");
        } else {
          yield UserUpdateFailedState(error: "update failed");
        }
      } catch (e) {
        yield UserUpdateFailedState(error: "update function exception");
      }
    }
  }
}
