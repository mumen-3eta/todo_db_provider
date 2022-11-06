import 'dart:developer';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_db_provider/models/task_model.dart';

class DBhelper {
  DBhelper._();
  static DBhelper dbhelper = DBhelper._();
  static const String tableName = 'tasks';
  static const String taskIdColumName = 'id';
  static const String taskNameColumName = 'taskName';
  static const String taskIsCompleteColumName = 'taskComplete';
  late Database database;
  initDatabase() async {
    database = await createConnectionWithDatabase();
  }

  Future<Database> createConnectionWithDatabase() async {
    String databasePath = await getDatabasesPath();
    String databaseName = 'tasks.db';
    String fullPath = join(databasePath, databaseName);
    Database database =
        await openDatabase(fullPath, version: 1, onCreate: (db, i) {
      log('table created');
      db.execute('''CREATE TABLE $tableName (
            $taskIdColumName INTEGER PRIMARY KEY AUTOINCREMENT, 
            $taskNameColumName TEXT, 
            $taskIsCompleteColumName INTEGER)
            ''');
    }, onOpen: (db) {
      log('table opened');
    });

    return database;
  }

  inserrNewTask(TaskModel task) async {
    int rowIndex = await database.insert(tableName, task.toMap());
    log(rowIndex.toString());
  }

  Future<List<TaskModel>> selectAllTasks() async {
    List<Map<String, Object?>> tasksMap = await database.query(tableName);
    List<TaskModel> tasks = tasksMap.map((e) => TaskModel.fromMap(e)).toList();
    return tasks;
  }

  selectOneTask(int id) {
    database.query(tableName, where: '$taskIdColumName = ?', whereArgs: [id]);
  }

  updateOneTask(TaskModel task) {
    database.update(tableName, task.toMap(),
        where: '$taskIdColumName = ?', whereArgs: [task.id]);
  }

  deleteOneTask(int id) {
    database.delete(tableName, where: '$taskIdColumName = ?', whereArgs: [id]);
  }
}
