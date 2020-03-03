import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/app_drawer.dart';
import '../helpers/widget_helper.dart';
import '../providers/task_types_provider.dart';
import '../providers/task_provider.dart';
import '../models/tasks.dart';
import '../widgets/home/task_card.dart';

class CompletedTasksScreen extends StatefulWidget {
  static const pageRouteName = '/completed-tasks';

  @override
  _CompletedTasksScreenState createState() => _CompletedTasksScreenState();
}

class _CompletedTasksScreenState extends State<CompletedTasksScreen> {
  List<PopupMenuItem> _popMenus;
  int taskFilter = 0;

  @override
  void initState() {
    super.initState();
    _popMenus = [];

    _popMenus.add(WidgetHelper.getTasktypePopUpMenu("0", "Show All Tasks"));

    Provider.of<TaskTypeProvider>(context, listen: false)
        .fetchAndSetTasktypes()
        .then((list) {
      list.forEach((t) {
        _popMenus
            .add(WidgetHelper.getTasktypePopUpMenu(t.id.toString(), t.title));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final tasks = Provider.of<TaskProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Completed Tasks',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (value) {
              setState(() {
                taskFilter = int.parse(value);
              });
            },
            itemBuilder: (_) => _popMenus,
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).primaryColorDark,
      body: SafeArea(
        child: FutureBuilder<List<Task>>(
          future: tasks.getAllTasks(taskFilter, 1),
          builder: (ctx, data) {
            if (data.hasData) {
              return ListView.builder(
                itemCount: data.data.length,
                itemBuilder: (ctx, i) {
                  Task task = data.data[i];
                  return TaskCard(
                    task,
                  );
                },
              );
            } else {
              return Center(
                  child:const Text('No task found. Try to add some!',
                      style: TextStyle(color: Colors.white)));
            }
          },
        ),
      ),
      drawer: AppDrawer(),
    );
  }
}
