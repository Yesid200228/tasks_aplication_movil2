import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:task_aplicattion2/models/activity/activity_modelPost.dart';
import 'package:task_aplicattion2/services/url.dart';

class ActivitiesService{
  String _url = UrlService().url;
  Dio dio = Dio();

  Future<List> createActivity(ActivityModelPost activity) async {

    final url = '$_url/activities';

    // print(resp.data);
    // print(resp.statusCode);
      try {
      Response resp = await dio.post(url, data: activityModelPostToJson(activity));
      resp;

      return [resp.statusCode,'Actividad Registrada'];

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
  
  Future<int> deleteActivities(String id) async {

    final url = '$_url/activities/$id';

    final resp = await dio.delete(url);

    return resp.statusCode;
  }


  Future<List<ActivityModelPost>> cargarActivities(BuildContext context) async {
    final url = '$_url/activities';

    final resp = await dio.get(url);

    final List<ActivityModelPost> activities = [];
    //Imprimir array que llega
    // print(resp.data['data'][0]['id']);
    for (var item in resp.data['data']) {
      final activity = ActivityModelPost.fromJson(item);
      activities.add(activity);
    }
    return activities;
  }
}