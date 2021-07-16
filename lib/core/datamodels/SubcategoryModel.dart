// To parse this JSON data, do
//
//     final subcategoryModels = subcategoryModelsFromJson(jsonString);

import 'dart:convert';

List<SubcategoryModels> subcategoryModelsFromJson(List<dynamic> str) => List<SubcategoryModels>.from((str).map((x) => SubcategoryModels.fromJson(x)));
String subcategoryModelsToJson(List<SubcategoryModels> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SubcategoryModels {
  SubcategoryModels({
    this.code,
    this.name,
    this.type,
  });

  String code;
  String name;
  String type;

  factory SubcategoryModels.fromJson(Map<String, dynamic> json) => SubcategoryModels(
    code: json["Code"],
    name: json["name"],
    type: json["Type"],
  );

  Map<String, dynamic> toJson() => {
    "Code": code,
    "name": name,
    "Type": type,
  };
}
