import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flushbar/flushbar.dart';

import '../providers/task_types_provider.dart';

class AddNewTaskTypeScreen extends StatefulWidget {
  static const pageRouteName = '/add-new-task-type';

  @override
  _AddNewTaskTypeScreenState createState() => _AddNewTaskTypeScreenState();
}

class _AddNewTaskTypeScreenState extends State<AddNewTaskTypeScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  void _saveTaskType() {
    String title = _titleController.text.trim();
    String description = _descriptionController.text.trim();

    if(title.isEmpty || description.isEmpty){
     Flushbar(
          title: 'Invalid input!',
          message: 'Please provide both title and description',
          icon: const Icon(Icons.error_outline, color: Colors.red,),
          leftBarIndicatorColor: Theme.of(context).errorColor,
          duration: Duration(seconds: 2),
        ).show(context);
      return;
    }
    Provider.of<TaskTypeProvider>(context, listen: false)
        .addTaskType(title, description);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add New Task Type',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
         Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(10),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(labelText: 'Title'),
                      controller: _titleController,
                    ),
                    SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(labelText: 'Description'),
                      controller: _descriptionController,
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
            ),
          ),
          RaisedButton.icon(
            icon: const Icon(Icons.add),
            textColor: Colors.white,
            label: Text(
              'Add Place',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            onPressed: _saveTaskType,
            elevation: 0,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            color: Theme.of(context).primaryColorDark,
          ),
        ],
      ),
    );
  }
}
