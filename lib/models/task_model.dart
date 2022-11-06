import 'package:todo_db_provider/data/db_helper.dart';

class TaskModel {
  int? id;
  String? title;
  late bool isComplete;

  TaskModel({
    required this.title,
    this.isComplete = false,
  });

  TaskModel.fromMap(Map<String, dynamic> map) {
    id = map[DBhelper.taskIdColumName];
    title = map[DBhelper.taskNameColumName];
    isComplete = map[DBhelper.taskIsCompleteColumName] == 1 ? true : false;
  }

  Map<String, dynamic> toMap() {
    return {
      DBhelper.taskNameColumName: title,
      DBhelper.taskIsCompleteColumName: isComplete ? 1 : 0
    };
  }
}
