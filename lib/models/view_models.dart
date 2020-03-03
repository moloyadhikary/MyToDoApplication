
import './tasks.dart';
import './sub_task.dart';

class ViewModels {

}


class VMTaskDetails {
  Task taskDetails;
  List<SubTask> subTasks;

  VMTaskDetails({this.taskDetails, this.subTasks});
}