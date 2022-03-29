import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:hotreloader/hotreloader.dart';
import 'package:provider/provider.dart';
import 'package:task_aplicattion2/providers/task_provider.dart';

import '../models/tareas/task_modelGet.dart';
import '../models/tareas/task_modelPost.dart';
import '../providers/snacbar_provider.dart';

class TasksService {
  final String _url = 'http://192.168.1.97:3000';
  Dio dio = Dio();


  TaskModelPost task = new TaskModelPost();

  Future<int> crearTask(TaskModelPost task) async {


    final url = '$_url/tasks';

    final resp = await dio.post(url, data: taskModelToJson(task));

    print(resp.data);
    // print(resp.statusCode);


    return resp.statusCode;
  }




  Future<List<TaskModelGet>> cargarTasks(BuildContext context) async {
    final taskProvider = Provider.of<TaskProvider>(context,listen: false);

    final url = '$_url/tasks';

    final resp = await dio.get(url);

    final List<TaskModelGet> tasks = [];
    //Imprimir array que llega
    // print(resp.data['data'][0]['id']);
      resp.data['data'].forEach((item) {
        // print(item);
        final prodTemp = TaskModelGet.fromJson(item);
        tasks.add(prodTemp);
      }
    );
  
   taskProvider.selectedListTask = tasks;


    return tasks;
  }

  Future<List<TaskModelGet>> cargarTasksTrue() async {
    final url = '$_url/tasks';
    // Map<String, dynamic> query;

    final resp = await dio.get(url);

    final List<TaskModelGet> tasks = [];
    //Imprimir array que llega
    // print(resp.data['data'][0]['id']);
    resp.data['data'].forEach((item) {
      // print(item);
      final prodTemp = TaskModelGet.fromJson(item);
      tasks.add(prodTemp);
    }
    );
    return tasks;
  }

  Future<int> editartask(TaskModelGet taskModelGet) async {
    final url = '$_url/tasks/${taskModelGet.id}';

    final resp = await dio.put(url, data: taskModelGetToJson(taskModelGet));

    return resp.statusCode;
  }

  Future<String> editarEstadoTask(String id)async{
    final url = '$_url/tasks/$id/status';
    await dio.put(url);

    return 'AQUIII';
  }

  Future<int> deleteTask(String id) async {


    final url = '$_url/tasks/$id';

   final resp = await dio.delete(url);


    return resp.statusCode;
  }
}
