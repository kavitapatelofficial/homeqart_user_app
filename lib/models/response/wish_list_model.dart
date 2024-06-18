// To parse this JSON data, do
//
//     final wishListModel = wishListModelFromJson(jsonString);

import 'dart:convert';

WishListModel wishListModelFromJson(String str) =>
    WishListModel.fromJson(json.decode(str));

String wishListModelToJson(WishListModel data) => json.encode(data.toJson());

class WishListModel {
  WishListModel({
    this.result,
  });

  List<Result>? result;

  factory WishListModel.fromJson(Map<String, dynamic> json) => WishListModel(
        result: json["result"] == null
            ? null
            : List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": result == null
            ? null
            : List<dynamic>.from(result!.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    this.id,
    this.productId,
    this.name,
    this.image,
    this.sellingPrice,
    this.price,
    this.discountType,
  });

  int? id;
  int? productId;
  String? name;
  String? image;
  int? sellingPrice;
  int? price;
  String? discountType;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        productId: json["product_id"],
        name: json["name"],
        image: json["image"],
        sellingPrice: json["selling_price"],
        price: json["price"],
        discountType: json["discount_type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "name": name,
        "image": image,
        "selling_price": sellingPrice,
        "price": price,
        "discount_type": discountType,
      };
}
