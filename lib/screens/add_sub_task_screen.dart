import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';
import 'package:provider/provider.dart';

import '../providers/sub_task_provider.dart';

class AddSubTaskScreen extends StatelessWidget {
  static const pageRouteName = '/add-sub-task';

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final taskId = int.parse(routeArgs['id']);
    final taskTitle = routeArgs['title'];
    final _titleController = TextEditingController();
    final _descriptionController = TextEditingController();

    _saveSubTask() {
      String subTaskTitle = _titleController.text.trim();
      String subTaskDescription = _descriptionController.text.trim();

      if (subTaskTitle.isEmpty || subTaskDescription.isEmpty || taskId.isNaN) {
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
      Provider.of<SubTaskProvider>(context, listen: false)
          .addSubTask(subTaskTitle, subTaskDescription, taskId);
      Navigator.of(context).pop(true);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          taskTitle,
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
                      Card(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            'Task: $taskTitle',
                            textAlign: TextAlign.center,
                            style:const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          width: double.infinity,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
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
              icon: const Icon(Icons.add),
              textColor: Colors.white,
              label: const Text(
                'Add Sub Task',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              onPressed: _saveSubTask,
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
