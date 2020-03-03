import 'package:flutter/foundation.dart';


import '../helpers/db_helper.dart';
import '../models/view_models.dart';
import '../models/tasks.dart';
import '../models/sub_task.dart';

class ViewModelsProvider with ChangeNotifier {

  Future<VMTaskDetails> getTaskDetails(int taskId) async {
    VMTaskDetails taskData = VMTaskDetails();

    var sql = 'SELECT t.*, p.title typeTitle FROM tasks t LEFT JOIN task_types p on t.typeId = p.id WHERE t.id = $taskId';
    var result = await DBHelper.rawQuery(sql); 
    var allTasks = result.isNotEmpty ? result.toList().map((t) => Task.fromMap(t)).toList() : null;
    if(allTasks!=null){
      taskData.taskDetails = allTasks.first;
    }

    sql = 'SELECT * FROM sub_tasks WHERE taskId = $taskId';
    result = await DBHelper.rawQuery(sql);
    var allSubTasks = result.toList().map((st) => SubTask.fromMap(st)).toList();
    taskData.subTasks = allSubTasks;

    return taskData;
  }

}