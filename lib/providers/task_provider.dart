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

  Future<List<Task>> getAllTasks(int filter, int isCompleted) async {
    String sql = 'SELECT t.id, t.title, t.description, t.createDate, t.updatedate, t.isCompleted, p.title typeTitle, count(st.id) numberOfSubTasks FROM tasks t LEFT JOIN task_types p on t.typeId = p.id LEFT JOIN sub_tasks st ON t.id = st.taskId WHERE t.isCompleted=$isCompleted GROUP BY t.id, t.title, t.description, t.createDate, t.updatedate, t.isCompleted, p.title';
    if(filter > 0){
      sql = 'SELECT t.id, t.title, t.description, t.createDate, t.updatedate, t.isCompleted, p.title typeTitle, count(st.id) numberOfSubTasks FROM tasks t LEFT JOIN task_types p on t.typeId = p.id LEFT JOIN sub_tasks st ON t.id = st.taskId WHERE P.ID = $filter and t.isCompleted=$isCompleted GROUP BY t.id, t.title, t.description, t.createDate, t.updatedate, t.isCompleted, p.title';
    }
    var result = await DBHelper.rawQuery(sql);
    List<Task> tasks = result.isNotEmpty ? result.toList().map((t) => Task.fromMap(t)).toList() : null;
    return tasks;
  }

  Future<Task> getTaskById(int id) async {
     var sql = 'SELECT * FROM tasks WHERE ID = $id';
    var result = await DBHelper.rawQuery(sql); 
    var allTasks = result.isNotEmpty ? result.toList().map((t) => Task.fromMap(t)).toList() : null;
    if(allTasks==null){
      return null;
    }
    return allTasks.first;
  }

  void addTask(String title, String description, int typeId){
    DBHelper.insert('tasks', {
      'typeId': typeId,
      'title': title,
      'description': description,
      'createDate': DateTime.now().toIso8601String(),
      'updateDate': DateTime.now().toIso8601String(),
      'isCompleted': 0,
    });
  }

   void updateTask(Task t){
      String sql = 'UPDATE tasks SET title="${t.title}", description="${t.description}", updateDate="${DateTime.now().toIso8601String()}", typeId=${t.typeId} WHERE id=${t.id}';
      DBHelper.updateQuery(sql);
    }

    void setTaskIsCompleted(int id, int newStatus){
     String sql = 'UPDATE tasks SET isCompleted=$newStatus WHERE id=$id';
      DBHelper.updateQuery(sql);
  }
  
}