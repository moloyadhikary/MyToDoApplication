import 'package:flutter/foundation.dart';

import '../models/task_types.dart';
import '../helpers/db_helper.dart';

class TaskTypeProvider with ChangeNotifier {

  List<Tasktypes> _tasktypes = [];


  List<Tasktypes> get getTaskTypes {
    return [..._tasktypes];
  }

  void addTaskType(String title, String description){
    DBHelper.insert('task_types', {
      'title': title,
      'description': description,
    });
  }

  Future<Tasktypes> getTaskTypeById(int id) async {
     var sql = 'SELECT * FROM task_types WHERE ID = $id';
    var result = await DBHelper.rawQuery(sql); 
    var allTaskTypes = result.isNotEmpty ? result.toList().map((t) => Tasktypes.fromMap(t)).toList() : null;
    if(allTaskTypes==null){
      return null;
    }
    return allTaskTypes.first;
  }



  Future<List<Tasktypes>> fetchAndSetTasktypes() async {
    final dataList = await DBHelper.getData('task_types');
    _tasktypes = dataList
        .map(
          (item) => Tasktypes(
                id: item['id'],
                title: item['title'],
                description: item['description'],
              ),
        )
        .toList();
    notifyListeners();
    return _tasktypes;
  }

  void updateTaskType(Tasktypes type){
      String sql = 'UPDATE task_types SET title="${type.title}", description="${type.description}" WHERE id=${type.id}';
      DBHelper.updateQuery(sql);
    }

}