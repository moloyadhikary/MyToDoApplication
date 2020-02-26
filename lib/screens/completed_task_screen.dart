import 'package:flutter/material.dart';

import '../widgets/app_drawer.dart';

class CompletedTasksScreen extends StatelessWidget {
  static const pageRouteName = '/completed-tasks';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Completed Tasks',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Text('This is where we show completed tasks'),
      ),
      drawer: AppDrawer(),
    );
  }
}
