import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flushbar/flushbar.dart';


import '../models/task_types.dart';
import '../providers/task_types_provider.dart';


class EditTaskTypeScreen extends StatefulWidget {
  static const pageRouteName = '/edit_task_type';
  @override
  _EditTaskTypeScreenState createState() => _EditTaskTypeScreenState();
}

class _EditTaskTypeScreenState extends State<EditTaskTypeScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  int _taskTypeId = 0;
  Tasktypes type;


@override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, (){
      _taskTypeId = ModalRoute.of(context).settings.arguments as int;

      Provider.of<TaskTypeProvider>(context, listen: false).getTaskTypeById(_taskTypeId).then((val) {
        type = val;
        _titleController.text = type.title;
        _descriptionController.text = type.description;
      });
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  _updateTaskType() {
    String typeTitle = _titleController.text.trim();
    String typeDescription = _descriptionController.text.trim();
    if (typeTitle.isEmpty || typeDescription.isEmpty) {
      Flushbar(
        title: 'Invalid input!',
        message: 'Please provide sub task title',
        icon: const Icon(
          Icons.error_outline,
          color: Colors.red,
        ),
        leftBarIndicatorColor: Theme.of(context).errorColor,
        duration: Duration(seconds: 2),
      ).show(context);
      return;
    }
    type.title = typeTitle;
    type.description = typeDescription;
    Provider.of<TaskTypeProvider>(context, listen: false).updateTaskType(type);
    Navigator.of(context).pop(true);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Task Type',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        decoration:const InputDecoration(labelText: 'Title'),
                        controller: _titleController,
                      ),
                      SizedBox(height: 10),
                      TextField(
                        decoration:const InputDecoration(labelText: 'Description'),
                        controller: _descriptionController,
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            RaisedButton.icon(
              icon: const Icon(Icons.save),
              textColor: Colors.white,
              label: const Text(
                'Save Task Type',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              onPressed: _updateTaskType,
              elevation: 0,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              color: Theme.of(context).primaryColorDark,
            ),
          ],
        ),
      ),
    );
  }
}