// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

List<CategoryModel> categoryModelFromJson(String str) =>
    List<CategoryModel>.from(
        json.decode(str).map((x) => CategoryModel.fromJson(x)));

String categoryModelToJson(List<CategoryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoryModel {
  CategoryModel({
    this.id,
    this.name,
    this.parentId,
    this.image,
    this.banner,
  });

  int? id;
  String? name;
  int? parentId;
  String? image;
  String? banner;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["id"],
        name: json["name"],
        parentId: json["parent_id"],
        image: json["image"],
        banner: json["banner"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "parent_id": parentId,
        "image": image,
        "banner": banner,
      };
}
