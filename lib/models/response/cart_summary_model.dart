// To parse this JSON data, do
//
//     final cartSummaryModel = cartSummaryModelFromJson(jsonString);

import 'dart:convert';

CartSummaryModel cartSummaryModelFromJson(String str) =>
    CartSummaryModel.fromJson(json.decode(str));

String cartSummaryModelToJson(CartSummaryModel data) =>
    json.encode(data.toJson());

class CartSummaryModel {
  CartSummaryModel({
    this.subTotal,
    this.couponAmount,
    this.shiping,
    this.total,
  });

  int? subTotal;
  int? couponAmount;
  String? shiping;
  int? total;

  factory CartSummaryModel.fromJson(Map<String, dynamic> json) =>
      CartSummaryModel(
        subTotal: json["sub_total"],
        couponAmount: json["coupon_amount"],
        shiping: json["shiping"].toString(),
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "sub_total": subTotal,
        "coupon_amount": couponAmount,
        "shiping": shiping.toString(),
        "total": total,
      };
}
