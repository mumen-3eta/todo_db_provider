import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_db_provider/data/db_provider.dart';
import '../../models/task_model.dart';

class NewTaskScreen extends StatelessWidget {
  NewTaskScreen();
  String content = "";
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<DB_provider>(
      builder: (context, provider, child) {
        return Scaffold(
            appBar: AppBar(),
            body: Column(
              children: [
                TextField(
                  onChanged: (v) {
                    content = v;
                  },
                ),
                ElevatedButton(
                    onPressed: () async {
                      TaskModel task = TaskModel(title: content);
                      await provider.addNewTask(task);
                      Navigator.of(context).pop();
                    },
                    child: const Text('Add New Task'))
              ],
            ));
      },
    );
  }
}
