// To parse this JSON data, do
//
//     final taskModelGet = taskModelGetFromJson(jsonString);

import 'dart:convert';

TaskModelGet taskModelGetFromJson(String str) => TaskModelGet.fromJson(json.decode(str));

String taskModelGetToJson(TaskModelGet data) => json.encode(data.toJson());

class TaskModelGet {
    TaskModelGet({
      this.id='',
      this.name = '' ,
      this.description= '',
      this.status=true,
    });

    String id;
    String name ;
    String description ;
    bool status;

    factory TaskModelGet.fromJson(Map<String, dynamic> json) => TaskModelGet(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "status": status,
    };
}
