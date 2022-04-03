// To parse this JSON data, do
//
//     final errorModel = errorModelFromJson(jsonString);

import 'dart:convert';

ErrorModel errorModelFromJson(String str) => ErrorModel.fromJson(json.decode(str));

String errorModelToJson(ErrorModel data) => json.encode(data.toJson());

class ErrorModel {
    ErrorModel({
        this.statusCode,
        this.message,
        this.error,
    });

    int statusCode;
    List<String> message;
    String error;

    factory ErrorModel.fromJson(Map<String, dynamic> json) => ErrorModel(
        statusCode: json["statusCode"],
        message: List<String>.from(json["message"].map((x) => x)),
        error: json["error"],
    );

    Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": List<dynamic>.from(message.map((x) => x)),
        "error": error,
    };
}
