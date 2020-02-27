import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/app_drawer.dart';
import '../screens/add_new_task_screen.dart';
import '../models/tasks.dart';
import '../providers/task_provider.dart';
import '../widgets/home/task_card.dart';

class HomeScreen extends StatefulWidget {
  static const pageRouteName = '/home';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final tasks = Provider.of<TaskProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My To Do',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddNewTaskScreen.pageRouteName);
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Task>>(
        future: tasks.getAllTasks(),
        builder: (ctx, data) {
          if (data.hasData) {
            return ListView.builder(
              itemCount: data.data.length,
              itemBuilder: (ctx, i) {
                Task task = data.data[i];
                return task.isCompleted == false ? TaskCard(task, data.data.indexOf(task) + 1) : null;
              },
            );
          } else {
            return Center(child: Text('No task found. Try to add some!'));
          }
        },
      ),
      drawer: AppDrawer(),
    );
  }
}
