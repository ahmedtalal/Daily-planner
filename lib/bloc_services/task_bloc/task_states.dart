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
