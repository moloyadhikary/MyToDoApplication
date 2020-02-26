import 'package:flutter/material.dart';


import '../widgets/app_drawer.dart';
import '../screens/add_new_task_screen.dart';

class HomeScreen extends StatefulWidget {
  static const pageRouteName = '/home';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My To Do',  style: TextStyle(fontWeight: FontWeight.bold),),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddNewTaskScreen.pageRouteName);
            },
          ),
        ],
      ),
      body: Center(
        child: Text('This is your home screen'),
      ),
      drawer: AppDrawer(),
    );
  }
}
