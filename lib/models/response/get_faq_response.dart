// To parse this JSON data, do
//
//     final getFaqResponse = getFaqResponseFromJson(jsonString);

import 'dart:convert';

List<GetFaqResponse> getFaqResponseFromJson(String str) =>
    List<GetFaqResponse>.from(
        json.decode(str).map((x) => GetFaqResponse.fromJson(x)));

String getFaqResponseToJson(List<GetFaqResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetFaqResponse {
  GetFaqResponse({
    this.id,
    this.question,
    this.answer,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? question;
  String? answer;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory GetFaqResponse.fromJson(Map<String, dynamic> json) => GetFaqResponse(
        id: json["id"],
        question: json["question"],
        answer: json["answer"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "question": question,
        "answer": answer,
        "status": status,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
