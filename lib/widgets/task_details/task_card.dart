import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/view_models.dart';
import '../../models/sub_task.dart';


class TaskCardOnTaskDetails extends StatelessWidget {
  final VMTaskDetails _vmTaskDetails;
  final Function _onCompletetionHit;
  final Function _onEditHit;

  TaskCardOnTaskDetails(this._vmTaskDetails, this._onCompletetionHit, this._onEditHit);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate([
        Card(
          margin:const EdgeInsets.all(8),
          child: Container(
            padding: const EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                    DateFormat('MMMM dd, yyyy  hh:mm a')
                        .format(_vmTaskDetails.taskDetails.createDate),
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Divider(),
                const Text('Created On'),
              ],
            ),
          ),
        ),
        Card(
          margin:const EdgeInsets.all(8),
          child: Container(
            padding: const EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(_vmTaskDetails.taskDetails.description,
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Divider(),
                const Text('Description'),
              ],
            ),
          ),
        ),
        Card(
          margin:const EdgeInsets.all(8),
          child: Container(
            padding: const EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(_vmTaskDetails.taskDetails.typeTitle,
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Divider(),
                const Text('Task Type'),
              ],
            ),
          ),
        ),
        Card(
          margin:const EdgeInsets.all(8),
          child: Container(
            padding: const EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                    _vmTaskDetails.taskDetails.isCompleted
                        ? DateFormat('MMMM dd, yyyy  hh:mm a')
                            .format(_vmTaskDetails.taskDetails.updateDate)
                        : 'Not Completed Yet',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Divider(),
                const Text('Completed On'),
              ],
            ),
          ),
        ),
        Container(
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('----'),
              Text(
                ' Sub Tasks (${_vmTaskDetails.subTasks.length}) ',
                style:const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const Text('----'),
            ],
          ),
        ),
        Container(          
          child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _vmTaskDetails.subTasks.length,
              itemBuilder: (ctx, i) {
                SubTask st = _vmTaskDetails.subTasks.elementAt(i);
                return Card(
                  margin: EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(
                      st.title,
                      style: TextStyle(
                          color: st.isCompleted ? Colors.green : null,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(st.description),
                    leading: st.isCompleted
                        ? Icon(
                            Icons.check_circle,
                            color: Colors.purple,
                          )
                        : IconButton(
                            icon: Icon(
                              Icons.check_circle_outline,
                              color: Colors.green,
                            ),
                            onPressed: () {return _onCompletetionHit(st.id);}),
                    trailing: st.isCompleted
                        ? null
                        : IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: Colors.purple,
                            ),
                            onPressed: () {return _onEditHit(st.id);}),
                  ),
                );
              }),
        ),
      ]),
    );
  }
}
