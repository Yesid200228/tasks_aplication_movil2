
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:task_aplicattion2/models/tareas/task_modelGet.dart';

class TaskProvider extends ChangeNotifier {
  TaskModelGet _taskModelGet = TaskModelGet();
  List<TaskModelGet> listTasks = [];


  TaskModelGet get selectedTask {
    return _taskModelGet;
  }
  List<TaskModelGet> get listTaskModelGet {
    return listTasks;
  }


  set selectedTask( TaskModelGet taskModelGet ){

    _taskModelGet = taskModelGet;

    notifyListeners();
  }


  set selectedListTask( List<TaskModelGet> listTaskModelGet ){

    listTasks = listTaskModelGet;

    notifyListeners();
  }
}