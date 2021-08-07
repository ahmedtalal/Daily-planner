import 'package:daily_planner/bloc_services/task_bloc/task_events.dart';
import 'package:daily_planner/bloc_services/task_bloc/task_states.dart';
import 'package:daily_planner/database/repository/db_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskBloc extends Bloc<TaskEvents, TaskStates> {
  FirebaseRepositoryModel repositoryModel;
  TaskBloc({
    required this.repositoryModel,
  }) : super(TaskInitialState());

  @override
  Stream<TaskStates> mapEventToState(TaskEvents event) {
    // TODO: implement mapEventToState
    throw UnimplementedError();
  }
}
