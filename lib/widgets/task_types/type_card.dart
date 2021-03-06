import 'package:flutter/material.dart';

import '../../models/task_types.dart';
import '../../screens/edit_task_type_screen.dart';

class TypeCard extends StatelessWidget {
  final Tasktypes type;

  TypeCard(this.type);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          type.title,
          style:const TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: CircleAvatar(
            child: Text(
          type.id.toString(),
          style: TextStyle(fontWeight: FontWeight.bold),
        )),
        subtitle: Text(type.description),
        trailing: IconButton(
            icon: Icon(Icons.edit),
            color: Theme.of(context).primaryColor,
            onPressed: () {
              Navigator.of(context).pushNamed(EditTaskTypeScreen.pageRouteName, arguments: type.id);
            }),
      ),
    );
  }
}
