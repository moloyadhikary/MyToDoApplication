import 'package:flutter/material.dart';


import './screens/home_screen.dart';
import './screens/task_types_screen.dart';
import './screens/add_new_task_type_screen.dart';
import './screens/add_new_task_screen.dart';
import './screens/completed_task_screen.dart';
import './screens/settings_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My To Do',
      theme: ThemeData(        
        primarySwatch: Colors.purple,
        accentColor: Colors.deepOrange,
        fontFamily: 'Ubuntu',
      ),
      home: HomeScreen(),
      routes: {
        HomeScreen.pageRouteName: (ctx) => HomeScreen(),
        TasktypesScreen.pageRouteName: (ctx) => TasktypesScreen(),
        AddNewTaskTypeScreen.pageRouteName: (ctx) => AddNewTaskTypeScreen(),
        AddNewTaskScreen.pageRouteName: (ctx) => AddNewTaskScreen(),
        CompletedTasksScreen.pageRouteName: (ctx) => CompletedTasksScreen(),
        SettingsScreen.pageRouteName: (ctx) => SettingsScreen(),
      },
    );
  }
}