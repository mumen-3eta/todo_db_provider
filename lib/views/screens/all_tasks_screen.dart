import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:todo_db_provider/data/db_provider.dart';
import '../widgets/task_widget.dart';

class AllTasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider.of<DB_provider>(context).allTasks.isEmpty
        ? Lottie.asset('assets/animations/empty.json')
        : Consumer<DB_provider>(
            builder: (context, provider, child) {
              return ListView.builder(
                  itemCount: provider.allTasks.length,
                  itemBuilder: (context, index) {
                    return TaskWidget(provider.allTasks[index]);
                  });
            },
          );
  }
}
