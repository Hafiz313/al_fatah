// To parse this JSON data, do
//
//     final fyearModels = fyearModelsFromJson(jsonString);

import 'dart:convert';

List<FyearModels> fyearModelsFromJson(List<dynamic> str) => List<FyearModels>.from((str).map((x) => FyearModels.fromJson(x)));
String fyearModelsToJson(List<FyearModels> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FyearModels {
  FyearModels({
    this.code,
    this.description,
  });

  String code;
  String description;

  factory FyearModels.fromJson(Map<String, dynamic> json) => FyearModels(
    code: json["Code"],
    description: json["Description"],
  );

  Map<String, dynamic> toJson() => {
    "Code": code,
    "Description": description,
  };
}
