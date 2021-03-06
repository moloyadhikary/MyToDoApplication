import 'package:flutter/material.dart';

import '../screens/task_types_screen.dart';
import '../screens/completed_task_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/about_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title:const Text('Personalize My To Do'),
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.of(context).pop(null);
                  },
                );
              },
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: Text(
              'Home',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          Divider(),
          ListTile(
            leading: const Icon(Icons.list),
            title: Text(
              'Task Types',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(TasktypesScreen.pageRouteName);
            },
          ),
          Divider(),
          ListTile(
            leading: const Icon(Icons.done_all),
            title: Text(
              'Completed Tasks',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(CompletedTasksScreen.pageRouteName);
            },
          ),
          Divider(),
          ListTile(
            leading: const Icon(Icons.tune),
            title: Text(
              'Settings',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(SettingsScreen.pageRouteName);
            },
          ),
          Divider(),
          ListTile(
            leading: const Icon(Icons.info),
            title: Text(
              'About App',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(AboutScreen.pageRouteName);
            },
          ),
        ],
      ),
    );
  }
}
