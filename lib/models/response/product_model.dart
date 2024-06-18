// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel({
    this.totalSize,
    this.limit,
    this.offset,
    this.products,
  });

  int? totalSize;
  dynamic limit;
  dynamic offset;
  List<Product>? products;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        totalSize: json["total_size"],
        limit: json["limit"],
        offset: json["offset"],
        products: json["products"] == null
            ? null
            : List<Product>.from(
                json["products"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total_size": totalSize,
        "limit": limit,
        "offset": offset,
        "products": products == null
            ? null
            : List<dynamic>.from(products!.map((x) => x.toJson())),
      };
}

class Product {
  Product({
    this.id,
    this.name,
    this.image,
    this.offAmount,
    this.mrp,
    this.sellingPrice,
    this.wishlistCount,
  });

  int? id;
  String? name;
  List<String>? image;
  int? offAmount;
  int? mrp;
  int? sellingPrice;
  int? wishlistCount;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        image: json["image"] == null
            ? null
            : List<String>.from(json["image"].map((x) => x)),
        offAmount: json["off_amount"],
        mrp: json["price"],
        sellingPrice: json["selling_price"],
        wishlistCount: json["wishlist_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image":
            image == null ? null : List<dynamic>.from(image!.map((x) => x)),
        "off_amount": offAmount,
        "price": mrp,
        "wishlist_count": wishlistCount,
        "selling_price": sellingPrice,
      };
}
