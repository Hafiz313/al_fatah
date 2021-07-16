// To parse this JSON data, do
//
//     final locationModels = locationModelsFromJson(jsonString);

import 'dart:convert';

List<LocationModels> locationModelsFromJson(List<dynamic> str) => List<LocationModels>.from((str).map((x) => LocationModels.fromJson(x)));

String locationModelsToJson(List<LocationModels> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LocationModels {
  LocationModels({
    this.code,
    this.name,
  });

  String code;
  String name;

  factory LocationModels.fromJson(Map<String, dynamic> json) => LocationModels(
    code: json["Code"],
    name: json["Name"],
  );

  Map<String, dynamic> toJson() => {
    "Code": code,
    "Name": name,
  };
  @override
  String toString() {
    return '$code $name';
  }
}
