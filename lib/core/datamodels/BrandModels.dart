// To parse this JSON data, do
//
//     final brandModels = brandModelsFromJson(jsonString);

import 'dart:convert';

List<BrandModels> brandModelsFromJson(List<dynamic> str) => List<BrandModels>.from((str).map((x) => BrandModels.fromJson(x)));
String brandModelsToJson(List<BrandModels> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BrandModels {
  BrandModels({
    this.code,
    this.name,
  });




  String code;
  String name;

  factory BrandModels.fromJson(Map<String, dynamic> json) => BrandModels(
    code: json["Code"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "Code": code,
    "name": name,
  };
}
