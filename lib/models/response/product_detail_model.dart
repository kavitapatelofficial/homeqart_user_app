// To parse this JSON data, do
//
//     final productDetailModel = productDetailModelFromJson(jsonString);

import 'dart:convert';

ProductDetailModel productDetailModelFromJson(String str) =>
    ProductDetailModel.fromJson(json.decode(str));

String productDetailModelToJson(ProductDetailModel data) =>
    json.encode(data.toJson());

class ProductDetailModel {
  ProductDetailModel({
    this.totalSize,
    this.limit,
    this.offset,
    this.products,
  });

  int? totalSize;
  dynamic limit;
  dynamic offset;
  Products? products;

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) =>
      ProductDetailModel(
        totalSize: json["total_size"],
        limit: json["limit"],
        offset: json["offset"],
        products: json["products"] == null
            ? null
            : Products.fromJson(json["products"]),
      );

  Map<String, dynamic> toJson() => {
        "total_size": totalSize,
        "limit": limit,
        "offset": offset,
        "products": products == null ? null : products!.toJson(),
      };
}

class Products {
  Products({
    this.id,
    this.brandId,
    this.name,
    this.description,
    this.image,
    this.price,
    this.unit,
    this.totalStock,
    this.sellingPrice,
    this.offAmount,
    this.wishlistCount,
    this.rating,
  });

  int? id;
  dynamic brandId;
  String? name;
  String? description;
  List<String>? image;
  int? price;
  String? unit;
  int? totalStock;
  int? sellingPrice;
  int? offAmount;
  int? wishlistCount;
  List<Rating>? rating;

  factory Products.fromJson(Map<String, dynamic> json) => Products(
        id: json["id"],
        brandId: json["brand_id"],
        name: json["name"],
        description: json["description"],
        image: json["image"] == null
            ? null
            : List<String>.from(json["image"].map((x) => x)),
        price: json["price"],
        unit: json["unit"],
        totalStock: json["total_stock"],
        sellingPrice: json["selling_price"],
        offAmount: json["off_amount"],
        wishlistCount: json["wishlist_count"],
        rating: json["rating"] == null
            ? null
            : List<Rating>.from(json["rating"].map((x) => Rating.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "brand_id": brandId,
        "name": name,
        "description": description,
        "image":
            image == null ? null : List<dynamic>.from(image!.map((x) => x)),
        "price": price,
        "unit": unit,
        "total_stock": totalStock,
        "selling_price": sellingPrice,
        "off_amount": offAmount,
        "wishlist_count": wishlistCount,
        "rating": rating == null
            ? null
            : List<dynamic>.from(rating!.map((x) => x.toJson())),
      };
}

class Rating {
  Rating({
    this.average,
    this.productId,
  });

  String? average;
  int? productId;

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        average: json["average"],
        productId: json["product_id"],
      );

  Map<String, dynamic> toJson() => {
        "average": average,
        "product_id": productId,
      };
}
