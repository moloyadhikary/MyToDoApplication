import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flushbar/flushbar.dart';

import '../models/sub_task.dart';
import '../providers/sub_task_provider.dart';

class EditSubTaskScreen extends StatefulWidget {
  static const pageRouteName = '/edit-sub_task';
  @override
  _EditSubTaskScreenState createState() => _EditSubTaskScreenState();
}

class _EditSubTaskScreenState extends State<EditSubTaskScreen> {
  SubTask st;
  int subTaskId = 0;
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      subTaskId = ModalRoute.of(context).settings.arguments as int;
      setState(() {
        Provider.of<SubTaskProvider>(context, listen: false)
            .getSubTaskById(subTaskId)
            .then((val) {
          setState(() {
            st = val;
            _titleController.text = st.title;
            _descriptionController.text = st.description;
          });
        });
      });
    });
  }

  _updateSubTask() {
    String subTaskTitle = _titleController.text.trim();
    String subTaskDescription = _descriptionController.text.trim();
    if (subTaskTitle.isEmpty || subTaskDescription.isEmpty) {
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
    st.title = subTaskTitle;
    st.description = subTaskDescription;
    Provider.of<SubTaskProvider>(context, listen: false).updateSubTask(st);
    Navigator.of(context).pop(true);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Sub Task',
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
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        decoration:const InputDecoration(labelText: 'Title'),
                        controller: _titleController,
                      ),
                      SizedBox(),
                      TextField(
                        decoration:const InputDecoration(labelText: 'Description'),
                        controller: _descriptionController,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            RaisedButton.icon(
              icon: const Icon(Icons.save),
              textColor: Colors.white,
              label:const Text(
                'Save Sub Task',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              onPressed: _updateSubTask,
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
