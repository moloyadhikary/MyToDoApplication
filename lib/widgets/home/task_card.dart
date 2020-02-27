import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/tasks.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final int counter;

  TaskCard(this.task, this.counter);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        //color: Colors.teal[200],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ListTile(
              title: Text(
                task.title,
                style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).accentColor),
              ),
              leading: CircleAvatar(
                  child: Text(
                counter.toString(),
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              subtitle: Text(task.description, style: TextStyle(color: Colors.black)),
              trailing: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(DateFormat('MMM dd, yyyy').format(task.createDate)),
                  Text(DateFormat('hh:mm a').format(task.createDate)),
                ],
              ),
            ),
           Container(height: 1, color: Colors.grey,),
            Container(
              //color: Colors.teal[100],
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      task.typeTitle,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    VerticalDivider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    IconButton(
                        icon: const Icon(Icons.info_outline), onPressed: null),
                    VerticalDivider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    IconButton(icon: const Icon(Icons.edit), onPressed: null),
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
