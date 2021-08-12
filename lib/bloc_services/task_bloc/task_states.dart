abstract class TaskStates {}

class TaskInitialState extends TaskStates {}

class TaskAddedSucessState extends TaskStates {
  final messsage;
  TaskAddedSucessState({
    required this.messsage,
  });
}

class TaskAddedFailedState extends TaskStates {
  final error;
  TaskAddedFailedState({
    required this.error,
  });
}

class CurrentTaskLoadingState extends TaskStates {}

class CurrentTaskLoadedState extends TaskStates {
  final response;
  CurrentTaskLoadedState({
    required this.response,
  });
}

class CurrentTaskFailedLoadingState extends TaskStates {
  final error;
  CurrentTaskFailedLoadingState({
    required this.error,
  });
}

class ModifyTaskSuccessState extends TaskStates {
  final mesage;
  ModifyTaskSuccessState({
    required this.mesage,
  });
}

class ModifyTaskFailedState extends TaskStates {
  final error;
  ModifyTaskFailedState({
    required this.error,
  });
}

class ArchiveTaskLoadingState extends TaskStates {}

class ArchiveTaskLoadedState extends TaskStates {
  final response;
  ArchiveTaskLoadedState({
    required this.response,
  });
}

class ArchiveTaskFailedLoadingState extends TaskStates {
  final error;
  ArchiveTaskFailedLoadingState({
    required this.error,
  });
}
