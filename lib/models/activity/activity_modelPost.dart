// To parse this JSON data, do
//
//     final activityModelGet = activityModelGetFromJson(jsonString);

import 'dart:convert';

ActivityModelPost activityModelPostFromJson(String str) => ActivityModelPost.fromJson(json.decode(str));

String activityModelPostToJson(ActivityModelPost data) => json.encode(data.toJson());

class ActivityModelPost {
    ActivityModelPost({
      this.taskId='',
      this.dateEnd='',
      this.dateStart='',
    });

    String taskId;
    String dateEnd;
    String dateStart;

    factory ActivityModelPost.fromJson(Map<String, dynamic> json) => ActivityModelPost(
        taskId: json["taskId"],
        dateEnd: json["date_end"],
        dateStart: json["date_start"],
    );

    Map<String, dynamic> toJson() => {
        "taskId": taskId,
        "date_end": dateEnd,
        "date_start": dateStart,
    };
}
