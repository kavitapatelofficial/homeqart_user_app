// To parse this JSON data, do
//
//     final getBannersResponse = getBannersResponseFromJson(jsonString);

import 'dart:convert';

List<GetBannersResponse> getBannersResponseFromJson(String str) =>
    List<GetBannersResponse>.from(
        json.decode(str).map((x) => GetBannersResponse.fromJson(x)));

String getBannersResponseToJson(List<GetBannersResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetBannersResponse {
  GetBannersResponse({
    this.id,
    this.title,
    this.image,
    this.productId,
    this.status,
    this.categoryId,
  });

  int? id;
  String? title;
  String? image;
  int? productId;
  int? status;
  int? categoryId;

  factory GetBannersResponse.fromJson(Map<String, dynamic> json) =>
      GetBannersResponse(
        id: json["id"],
        title: json["title"],
        image: json["image"],
        productId: json["product_id"],
        status: json["status"],
        categoryId: json["category_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": image,
        "product_id": productId,
        "status": status,
        "category_id": categoryId,
      };
}
