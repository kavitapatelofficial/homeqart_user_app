// To parse this JSON data, do
//
//     final timeSlotModel = timeSlotModelFromJson(jsonString);

import 'dart:convert';

List<TimeSlotModel> timeSlotModelFromJson(String str) =>
    List<TimeSlotModel>.from(
        json.decode(str).map((x) => TimeSlotModel.fromJson(x)));

String timeSlotModelToJson(List<TimeSlotModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TimeSlotModel {
  TimeSlotModel({
    this.id,
    this.startTime,
    this.endTime,
  });

  int? id;
  String? startTime;
  String? endTime;

  factory TimeSlotModel.fromJson(Map<String, dynamic> json) => TimeSlotModel(
        id: json["id"],
        startTime: json["start_time"],
        endTime: json["end_time"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "start_time": startTime,
        "end_time": endTime,
      };
}
