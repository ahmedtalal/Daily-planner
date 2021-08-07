class TaskModel {
  late String task, date, description, category, firstTime, lastTime;
  late bool isDone;
  TaskModel({
    required this.task,
    required this.date,
    required this.description,
    required this.category,
    required this.firstTime,
    required this.lastTime,
    required this.isDone,
  });

  TaskModel.fromJson(Map<String, dynamic> data) {
    this.task = data["task"];
    this.date = data["date"];
    this.description = data["description"];
    this.category = data["category"];
    this.firstTime = data["firstTime"];
    this.lastTime = data["lastTime"];
    this.isDone = data["isDone"];
  }

  static Map<String, dynamic> toJson(TaskModel model) => {
        "task": model.task,
        "date": model.date,
        "description": model.description,
        "category": model.category,
        "firstTime": model.firstTime,
        "lastTime": model.lastTime,
        "isDone": model.isDone,
      };
}
