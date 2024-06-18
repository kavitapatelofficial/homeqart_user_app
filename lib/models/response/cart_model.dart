// To parse this JSON data, do
//
//     final cartModel = cartModelFromJson(jsonString);

import 'dart:convert';

CartModel cartModelFromJson(String str) => CartModel.fromJson(json.decode(str));

String cartModelToJson(CartModel data) => json.encode(data.toJson());

class CartModel {
  CartModel({
    this.result,
  });

  List<Result>? result;

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
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
    this.quantity,
    this.name,
    this.sellingPrice,
    this.image,
  });

  int? id;
  int? productId;
  int? quantity;
  String? name;
  int? sellingPrice;
  String? image;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        quantity: json["quantity"],
        productId: json["product_id"],
        name: json["name"],
        sellingPrice: json["selling_price"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "quantity": quantity,
        "product_id": productId,
        "name": name,
        "selling_price": sellingPrice,
        "image": image,
      };
}
