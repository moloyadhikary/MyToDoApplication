import 'package:flutter/foundation.dart';


import '../helpers/db_helper.dart';
import '../models/sub_task.dart';

class SubTaskProvider with ChangeNotifier {
  //List<SubTask> _subTasks = [];


  Future<List<SubTask>> getAllTasks(int taskId) async {
    String sql = 'SELECT * FROM sub_tasks where taskId = $taskId';
    var result = await DBHelper.rawQuery(sql);
    List<SubTask> tasks = result.isNotEmpty ? result.toList().map((t) => SubTask.fromMap(t)).toList() : null;
    return tasks;
  }

  void addSubTask(String title, String description, int taskId){
    DBHelper.insert('sub_tasks', {
      'taskId': taskId,
      'title': title,
      'description': description,
      'createDate': DateTime.now().toIso8601String(),
      'updateDate': DateTime.now().toIso8601String(),
      'isCompleted': 0,
    });    
  }

  Future<SubTask> getSubTaskById(int id) async {
     var sql = 'SELECT * FROM sub_tasks WHERE ID = $id';
    var result = await DBHelper.rawQuery(sql); 
    var allSubTasks = result.isNotEmpty ? result.toList().map((t) => SubTask.fromMap(t)).toList() : null;
    if(allSubTasks==null){
      return null;
    }
    return allSubTasks.first;
  }

  void updateSubTask(SubTask st){
      String sql = 'UPDATE sub_tasks SET title="${st.title}", description="${st.description}", updateDate="${DateTime.now().toIso8601String()}" WHERE id=${st.id}';
      DBHelper.updateQuery(sql);
    }
  
  void setSTIsCompleted(int id, int newStatus){
     String sql = 'UPDATE sub_tasks SET isCompleted=$newStatus WHERE id=$id';
      DBHelper.updateQuery(sql);
  }
}