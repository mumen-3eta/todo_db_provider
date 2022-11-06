import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todo_db_provider/data/db_helper.dart';
import 'package:todo_db_provider/models/task_model.dart';

class DB_provider extends ChangeNotifier {
  DB_provider() {
    log('message');
    getAllTasks();
  }
  List<TaskModel> allTasks = [];
  List<TaskModel> completeTasks = [];
  List<TaskModel> incompleteTasks = [];

  fillLists(List<TaskModel> tasks) {
    allTasks = tasks;
    completeTasks = tasks.where((element) => element.isComplete).toList();
    incompleteTasks = tasks.where((element) => !element.isComplete).toList();
    notifyListeners();
  }

  getAllTasks() async {
    List<TaskModel> tasks = await DBhelper.dbhelper.selectAllTasks();
    fillLists(tasks);
  }

  addNewTask(TaskModel task) async {
    await DBhelper.dbhelper.inserrNewTask(task);
    getAllTasks();
  }

  deleteTask(TaskModel task) async {
    await DBhelper.dbhelper.deleteOneTask(task.id!);
    getAllTasks();
  }

  updateTask(TaskModel task) async {
    task.isComplete = !task.isComplete;
    await DBhelper.dbhelper.updateOneTask(task);
    getAllTasks();
  }
}
