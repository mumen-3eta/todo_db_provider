import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_db_provider/data/db_helper.dart';
import 'package:todo_db_provider/data/db_provider.dart';
import 'package:todo_db_provider/views/screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBhelper.dbhelper.initDatabase();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DB_provider>(
          create: (context) {
            return DB_provider();
          },
        )
      ],
      child: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MainTodoPage());
  }
}
