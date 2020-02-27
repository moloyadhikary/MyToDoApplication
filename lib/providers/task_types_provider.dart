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

}