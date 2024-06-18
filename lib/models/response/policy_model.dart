// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<PolicyModel> welcomeFromJson(String str) => List<PolicyModel>.from(
    json.decode(str).map((x) => PolicyModel.fromJson(x)));

String welcomeToJson(List<PolicyModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PolicyModel {
  PolicyModel({
    this.id,
    this.key,
    this.value,
  });

  int? id;
  String? key;
  String? value;

  factory PolicyModel.fromJson(Map<String, dynamic> json) => PolicyModel(
        id: json["id"],
        key: json["key"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "key": key,
        "value": value,
      };
}
