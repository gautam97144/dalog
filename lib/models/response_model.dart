

import 'dart:convert';

ResponseModel responseModelFromJson(String str) => ResponseModel.fromJson(json.decode(str));

String responseModelToJson(ResponseModel data) => json.encode(data.toJson());

class ResponseModel {
  ResponseModel({
    this.sucecess,
    this.data,
    this.message,
  });

  bool? sucecess;
  List<dynamic>? data;
  String? message;

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
    sucecess: json["sucecess"] == null ? null : json["sucecess"],
    data: json["data"] == null ? null : List<dynamic>.from(json["data"].map((x) => x)),
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "sucecess": sucecess == null ? null : sucecess,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x)),
    "message": message == null ? null : message,
  };
}
