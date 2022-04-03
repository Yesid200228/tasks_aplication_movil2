import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:task_aplicattion2/providers/task_provider.dart';
import 'package:task_aplicattion2/services/url.dart';

import '../models/tareas/task_modelGet.dart';
import '../models/tareas/task_modelPost.dart';

class TasksService {
  String _url = UrlService().url;
  Dio dio = Dio();

  TaskModelPost task = new TaskModelPost();

  Future<List> crearTask(TaskModelPost task) async {

    final url = '$_url/tasks';

    // print(resp.data);
    // print(resp.statusCode);
      try {
      Response resp = await dio.post(url, data: taskModelToJson(task));
      resp;

      return [resp.statusCode,'Tarea Registrada'];

      } on DioError catch (e) {

        e.message;
        if (e.type == DioErrorType.connectTimeout) {
          throw Exception('');
        }
        var statusCode = e.response.data['statusCode'];
        var message = e.response.data['message'][0].toString();

        print(message);
        print(statusCode);

        // print(e.response.data['message'][0].toString());
        return [statusCode,message];

      }


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
    final url = '$_url/tasks/?filters=status||\$eq||1';
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

    return '';
  }

  Future<List> deleteTask(String id) async {

    final url = '$_url/tasks/$id';

    try {
    final resp = await dio.delete(url);
    return [resp.statusCode,'Tarea Eliminada'];

    } on DioError catch (e) {

      e.message;
      if (e.type == DioErrorType.connectTimeout) {
        throw Exception('');
      }
      var statusCode = e.response.data['statusCode'];
      var message = e.response.data['message'].toString();

      // print(e.response.data['message'][0].toString());
      return [statusCode,message];
      
    } catch (e) {
    }
  }
}
