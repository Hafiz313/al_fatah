// To parse this JSON data, do
//
//     final categoryModels = categoryModelsFromJson(jsonString);

import 'dart:convert';

List<CategoryModels> categoryModelsFromJson(List<dynamic> str) => List<CategoryModels>.from((str).map((x) => CategoryModels.fromJson(x)));

String categoryModelsToJson(List<CategoryModels> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoryModels {
  CategoryModels({
    this.code,
    this.name,
  });

  String code;
  String name;

  factory CategoryModels.fromJson(Map<String, dynamic> json) => CategoryModels(
    code: json["Code"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "Code": code,
    "name": name,
  };
}
