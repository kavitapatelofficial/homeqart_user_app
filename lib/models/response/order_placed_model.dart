// To parse this JSON data, do
//
//     final orderPlacedModel = orderPlacedModelFromJson(jsonString);

import 'dart:convert';

OrderPlacedModel orderPlacedModelFromJson(String str) =>
    OrderPlacedModel.fromJson(json.decode(str));

String orderPlacedModelToJson(OrderPlacedModel data) =>
    json.encode(data.toJson());

class OrderPlacedModel {
  OrderPlacedModel({
    this.message,
    this.orderId,
  });

  String? message;
  int? orderId;

  factory OrderPlacedModel.fromJson(Map<String, dynamic> json) =>
      OrderPlacedModel(
        message: json["message"],
        orderId: json["order_id"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "order_id": orderId,
      };
}
