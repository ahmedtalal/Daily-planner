import 'package:daily_planner/bloc_services/task_bloc/task_events.dart';
import 'package:daily_planner/bloc_services/task_bloc/task_states.dart';
import 'package:daily_planner/database/firebase/task_operations.dart';
import 'package:daily_planner/database/repository/db_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskBloc extends Bloc<TaskEvents, TaskStates> {
  FirebaseRepositoryModel repositoryModel;
  var taskModel;
  var taskId;
  TaskBloc({
    required this.repositoryModel,
  }) : super(TaskInitialState());

  @override
  Stream<TaskStates> mapEventToState(TaskEvents event) async* {
    if (event is CreateTaskEvent) {
      try {
        var response = await repositoryModel.addData(taskModel);
        if (response == true) {
          yield TaskAddedSucessState(messsage: "added successfully");
        } else {
          yield TaskAddedFailedState(error: "added unsuccessfully");
        }
      } catch (e) {
        yield TaskAddedFailedState(error: e.toString());
      }
    } else if (event is ShowCurrentTasksEvent) {
      yield CurrentTaskLoadingState();
      try {
        var result = repositoryModel.getAllData("model");
        yield CurrentTaskLoadedState(response: result);
      } catch (e) {
        yield CurrentTaskFailedLoadingState(error: e.toString());
      }
    } else if (event is UpdateTaskEvent) {
      try {
        var response = await repositoryModel.updateData(taskModel);
        if (response == true) {
          yield ModifyTaskSuccessState(mesage: "updated successfully");
        } else {
          yield ModifyTaskFailedState(error: "unsuccessfully");
        }
      } catch (e) {
        yield ModifyTaskFailedState(error: e.toString());
      }
    } else if (event is DeleteTaskEvent) {
      try {
        var response = await repositoryModel.deleteData(taskId);
        if (response == true) {
          yield ModifyTaskSuccessState(mesage: "deleted successfully");
        } else {
          yield ModifyTaskFailedState(error: "unsuccessfully");
        }
      } catch (e) {
        yield ModifyTaskFailedState(error: e.toString());
      }
    } else if (event is ArchiveTaskEvent) {
      try {
        var response = await TaskOperations().addArchiveTask(taskModel);
        if (response == true) {
          yield ModifyTaskSuccessState(mesage: "added in archive");
        } else {
          yield ModifyTaskFailedState(error: "unsuccessfully");
        }
      } catch (e) {
        yield ModifyTaskFailedState(error: e.toString());
      }
    } else if (event is ShowArchiveTasksEvent) {
      yield ArchiveTaskLoadingState();
      try {
        var result = TaskOperations().getAllArchiveData("model");
        yield ArchiveTaskLoadedState(response: result);
      } catch (e) {
        yield ArchiveTaskFailedLoadingState(error: e.toString());
      }
    } else if (event is DeleteArchiveTaskEvent) {
      try {
        var response = await TaskOperations().deleteArchiveTask(taskId);
        if (response == true) {
          yield ModifyTaskSuccessState(mesage: "deleted successfully");
        } else {
          yield ModifyTaskFailedState(error: "unsuccessfully");
        }
      } catch (e) {
        yield ModifyTaskFailedState(error: e.toString());
      }
    }
  }
}
