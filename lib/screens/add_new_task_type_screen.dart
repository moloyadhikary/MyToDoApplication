import 'package:flutter/material.dart';

class AddNewTaskTypeScreen extends StatelessWidget {
  static const pageRouteName = '/add-new-task-type';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add New Task Type',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Text('This is where we add new task type'),
      ),
    );
  }
}
