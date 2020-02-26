import 'package:flutter/material.dart';

import '../widgets/app_drawer.dart';
import '../screens/add_new_task_type_screen.dart';

class TasktypesScreen extends StatelessWidget {
  static const pageRouteName = '/taskTypes';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Manage Task Types',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Text('This is where we manage task types'),
      ),
      drawer: AppDrawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(AddNewTaskTypeScreen.pageRouteName);
        },
      ),
    );
  }
}
