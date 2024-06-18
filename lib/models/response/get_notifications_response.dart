// To parse this JSON data, do
//
//     final getNotificationResponse = getNotificationResponseFromJson(jsonString);

import 'dart:convert';

List<GetNotificationResponse> getNotificationResponseFromJson(String str) =>
    List<GetNotificationResponse>.from(
        json.decode(str).map((x) => GetNotificationResponse.fromJson(x)));

String getNotificationResponseToJson(List<GetNotificationResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetNotificationResponse {
  GetNotificationResponse({
    this.id,
    this.title,
    this.description,
    this.image,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? title;
  String? description;
  String? image;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory GetNotificationResponse.fromJson(Map<String, dynamic> json) =>
      GetNotificationResponse(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        image: json["image"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "image": image,
        "status": status,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
