import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/app_drawer.dart';
import '../screens/add_new_task_type_screen.dart';
import '../providers/task_types_provider.dart';
import '../models/task_types.dart';
import '../widgets/task_types/type_card.dart';

class TasktypesScreen extends StatelessWidget {
  static const pageRouteName = '/taskTypes';
  @override
  Widget build(BuildContext context) {
    final taskTypes = Provider.of<TaskTypeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Manage Task Types',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder<List<Tasktypes>>(
        future: taskTypes.fetchAndSetTasktypes(),
        builder: (ctx, data) {
          if (data.hasData) {
            return ListView.builder(
              itemCount: data.data.length,
              itemBuilder: (ctx, i) {
                Tasktypes taskType = data.data[i];
                return TypeCard(taskType);
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      drawer: AppDrawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(AddNewTaskTypeScreen.pageRouteName);
        },
      ),
    );
  }
}
