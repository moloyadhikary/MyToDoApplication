import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import '../models/view_models.dart';
import '../providers/view_models_provider.dart';
import '../screens/add_sub_task_screen.dart';
import '../widgets/task_details/task_card.dart';
import '../providers/sub_task_provider.dart';
import '../screens/edit_sub_task_screen.dart';

class TaskDetailsScreen extends StatefulWidget {
  static const pageRouteName = '/task-details';

  @override
  _TaskDetailsScreenState createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  VMTaskDetails _vmTaskDetails;
  int taskId = 0;
  var routeArgs;

  @override
  initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      setState(() {
        taskId = int.parse(routeArgs['id']);
      });
      _callSetState();
    });
  }

  _subTaskCompleted(int subTaskId) {
    AwesomeDialog(
        context: context,
        dialogType: DialogType.INFO,
        animType: AnimType.BOTTOMSLIDE,
        tittle: 'Confirm your action',
        desc: 'Are you sure that this sub-task is completed?',
        btnCancelOnPress: () {},
        btnOkOnPress: () {
          Provider.of<SubTaskProvider>(context, listen: false)
              .setSTIsCompleted(subTaskId, 1);
          _callSetState();
        }).show();
  }

  _subTaskEdit(int subTaskId) {
    Navigator.of(context)
        .pushNamed(EditSubTaskScreen.pageRouteName, arguments: subTaskId)
        .then((val) {
      if (val != null) {
        _callSetState();
      }
    });
  }

  _callSetState() {
    Provider.of<ViewModelsProvider>(context, listen: false)
        .getTaskDetails(taskId)
        .then((val) {
      setState(() {
        _vmTaskDetails = val;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //print('build');
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColorDark,
        body: _vmTaskDetails == null
            ? Center(child: CircularProgressIndicator())
            : CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    expandedHeight: 250,
                    pinned: true,
                    centerTitle: false,
                    flexibleSpace: FlexibleSpaceBar(
                      title: Text(_vmTaskDetails.taskDetails.title,
                          overflow: TextOverflow.ellipsis,
                          style:const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                      background: Hero(
                        tag: taskId,
                        child: Image.asset(
                          'assets/images/taskIcon.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    actions: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.playlist_add),
                        tooltip: 'Add Sub Task',
                        color: Theme.of(context).accentColor,
                        onPressed: () {
                          if (!_vmTaskDetails.taskDetails.isCompleted) {
                            Navigator.of(context).pushNamed(
                              AddSubTaskScreen.pageRouteName,
                              arguments: {
                                'id': _vmTaskDetails.taskDetails.id.toString(),
                                'title': _vmTaskDetails.taskDetails.title
                              },
                            ).then((onValue) {
                              if (onValue == true) {
                                _callSetState();
                              }
                            });
                          }
                        },
                      ),
                    ],
                  ),
                  TaskCardOnTaskDetails(
                      _vmTaskDetails, _subTaskCompleted, _subTaskEdit),
                ],
              ),
      ),
    );
  }
}
