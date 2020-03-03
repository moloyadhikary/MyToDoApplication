import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flushbar/flushbar.dart';

import '../models/tasks.dart';
import '../providers/task_provider.dart';
import '../helpers/widget_helper.dart';
import '../providers/task_types_provider.dart';

class EditTaskScreen extends StatefulWidget {
  static const pageRouteName = '/add-task';
  @override
  _EditTaskScreenState createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  List<DropdownMenuItem<String>> typeList;
  String ddlSelected = "0";
  Task task;
  int taskId = 0;

  @override
  initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      typeList = [];

      typeList.add(WidgetHelper.getTaskTypeDDL("0", "Select Task Type"));

      Provider.of<TaskTypeProvider>(context, listen: false)
          .fetchAndSetTasktypes()
          .then((list) {
        list.forEach((t) {
          typeList.add(
              WidgetHelper.getTaskTypeDDL(t.id.toString(), t.title.toString()));
        });
      });

      taskId = ModalRoute.of(context).settings.arguments as int;
      setState(() {
        Provider.of<TaskProvider>(context, listen: false)
            .getTaskById(taskId)
            .then((val) {
          setState(() {
            task = val;
            _titleController.text = task.title;
            _descriptionController.text = task.description;
            ddlSelected = task.typeId.toString();
          });
        });
      });
    });
  }

  void _saveTask() {
    String title = _titleController.text.trim();
    String description = _descriptionController.text.trim();
    if (ddlSelected == "0" || title.isEmpty || description.isEmpty) {
      Flushbar(
        title: 'Invalid input!',
        message: 'Please provide Task Type, Title and Description',
        icon: const Icon(
          Icons.error_outline,
          color: Colors.red,
        ),
        leftBarIndicatorColor: Theme.of(context).errorColor,
        duration: Duration(seconds: 2),
      ).show(context);
      return;
    }
    task.title = title;
    task.description = description;
    task.typeId = int.parse(ddlSelected);
    Provider.of<TaskProvider>(context, listen: false).updateTask(task);
    Navigator.of(context).pop();
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
          'Add New Task',
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
                      DropdownButton(
                        hint: Text('Chosse Task Type'),
                        value: ddlSelected,
                        items: typeList,
                        onChanged: (value) {
                          setState(() {
                            ddlSelected = value;
                          });
                        },
                        isExpanded: true,
                      ),
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
                'Save Task',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              onPressed: _saveTask,
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
