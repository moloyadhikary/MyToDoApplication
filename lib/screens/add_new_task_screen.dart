import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/task_provider.dart';

class AddNewTaskScreen extends StatefulWidget {
  static const pageRouteName= '/add-new-task';

  @override
  _AddNewTaskScreenState createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {

  void _saveTask(){
    Provider.of<TaskProvider>(context, listen: false).addTask('Test Task', 'Test Description', 1);
    Navigator.of(context).pop();
  }

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
        child: FlatButton(child: Text('Add'), onPressed: _saveTask,),
      ),
    );
  }
}