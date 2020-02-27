import 'package:flutter/cupertino.dart';

import '../models/tasks.dart';
import '../helpers/db_helper.dart';


class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];


  Future<List<Task>> fetchAndSetTasks() async {
    final dataList = await DBHelper.getData('tasks');
    _tasks = dataList
        .map(
          (item) => Task(
                id: item['id'],
                typeId: item['typeId'],
                title: item['title'],
                description: item['description'],
                createDate: DateTime.parse(item['createDate']),
                updateDate: DateTime.parse(item['updateDate']),
                isCompleted: item['isCompleted'] == 1 ? true : false
              ),
        )
        .toList();
    notifyListeners();
    return _tasks;
  }

  Future<List<Task>> getAllTasks() async {
    var result = await DBHelper.rawQuery('SELECT t.*, p.title typeTitle FROM tasks t LEFT JOIN task_types p on t.typeId = p.id');
    List<Task> tasks = result.isNotEmpty ? result.toList().map((t) => Task.fromMap(t)).toList() : null;
    return tasks;
  }

  void addTask(String title, String description, int typeId){
    DBHelper.insert('tasks', {
      'typeId': 1,
      'title': title,
      'description': description,
      'createDate': DateTime.now().toIso8601String(),
      'updateDate': DateTime.now().toIso8601String(),
      'isCompleted': 0,
    });
  }

}