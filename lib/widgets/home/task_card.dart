import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:provider/provider.dart';

import '../../models/tasks.dart';
import '../../screens/add_sub_task_screen.dart';
import '../../screens/task_details_screen.dart';
import '../../screens/edit_task_screen.dart';
import '../../providers/task_provider.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  //final int counter;

  TaskCard(this.task);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: Container(
        //color: Colors.teal[200],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ListTile(
              title: Text(
                task.title,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              leading: CircleAvatar(
                  child: Text(
                task.numberOfSubTasks.toString(),
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              subtitle: Text(
                task.typeTitle,
                style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.bold),
              ),
              trailing: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(DateFormat('MMM dd, yy').format(task.createDate)),
                  Text(DateFormat('hh:mm a').format(task.createDate)),
                ],
              ),
            ),
            Container(
              height: 1,
              color: Colors.grey,
            ),
            Container(
              //color: Colors.teal[100],
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    task.isCompleted
                        ? Icon(
                            Icons.check_circle,
                            color: Colors.purple,
                          )
                        : IconButton(
                            icon: const Icon(Icons.check_circle_outline,
                                color: Colors.green),
                            tooltip: 'Task Completed',
                            onPressed: () {
                              AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.INFO,
                                  animType: AnimType.BOTTOMSLIDE,
                                  tittle: 'Confirm your action',
                                  desc:
                                      'Are you sure that this sub-task is completed?',
                                  btnCancelOnPress: () {},
                                  btnOkOnPress: () {
                                    Provider.of<TaskProvider>(context,
                                            listen: false)
                                        .setTaskIsCompleted(task.id, 1);
                                    Navigator.of(context).pushNamed('/');
                                  }).show();
                            }),
                    VerticalDivider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    IconButton(
                        icon:
                            const Icon(Icons.info_outline, color: Colors.blue),
                        tooltip: 'Detailed Information',
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                            TaskDetailsScreen.pageRouteName,
                            arguments: {
                              'id': task.id.toString(),
                              'title': task.title
                            },
                          );
                        }),
                    VerticalDivider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    IconButton(
                        icon:
                            const Icon(Icons.playlist_add, color: Colors.green),
                        tooltip: 'Add Sub Task',
                        onPressed: () {
                          if (!task.isCompleted) {
                            Navigator.of(context).pushNamed(
                              AddSubTaskScreen.pageRouteName,
                              arguments: {
                                'id': task.id.toString(),
                                'title': task.title
                              },
                            );
                          }
                        }),
                    VerticalDivider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    IconButton(
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.purple,
                        ),
                        tooltip: 'Edit Task',
                        onPressed: () {
                          if (!task.isCompleted) {
                            Navigator.of(context).pushNamed(
                                EditTaskScreen.pageRouteName,
                                arguments: task.id);
                          }
                        }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
