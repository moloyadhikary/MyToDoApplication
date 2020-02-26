import 'package:flutter/material.dart';

class AddNewTaskScreen extends StatelessWidget {
  static const pageRouteName= '/add-new-task';
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add New Task',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Text('This is where we add new task'),
      ),
    );
  }
}