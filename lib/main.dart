import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/home_screen.dart';
import './screens/task_types_screen.dart';
import './screens/add_new_task_type_screen.dart';
import './screens/add_new_task_screen.dart';
import './screens/completed_task_screen.dart';
import './screens/settings_screen.dart';
import './screens/about_screen.dart';
import './screens/add_sub_task_screen.dart';
import './screens/task_details_screen.dart';
import './screens/edit_sub_task_screen.dart';
import './screens/edit_task_screen.dart';
import './screens/edit_task_type_screen.dart';

import './providers/task_types_provider.dart';
import './providers/task_provider.dart';
import './providers/sub_task_provider.dart';
import './providers/view_models_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: TaskTypeProvider()),
        ChangeNotifierProvider.value(value: TaskProvider()),
        ChangeNotifierProvider.value(value: SubTaskProvider()),
        ChangeNotifierProvider.value(value: ViewModelsProvider()),
      ],
      child: MaterialApp(
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
          AboutScreen.pageRouteName: (ctx) => AboutScreen(),
          AddSubTaskScreen.pageRouteName: (ctx) => AddSubTaskScreen(),
          TaskDetailsScreen.pageRouteName: (ctx) => TaskDetailsScreen(),
          EditSubTaskScreen.pageRouteName: (ctx) => EditSubTaskScreen(),
          EditTaskScreen.pageRouteName: (ctx) => EditTaskScreen(),
          EditTaskTypeScreen.pageRouteName: (ctx) => EditTaskTypeScreen(),
        },
      ),
    );
  }
}
