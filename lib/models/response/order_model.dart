// To parse this JSON data, do
//
//     final orderModel = orderModelFromJson(jsonString);

import 'dart:convert';

List<OrderModel> orderModelFromJson(String str) =>
    List<OrderModel>.from(json.decode(str).map((x) => OrderModel.fromJson(x)));

String orderModelToJson(List<OrderModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderModel {
  OrderModel({
    this.id,
    this.userId,
    this.orderAmount,
    this.couponDiscountAmount,
    this.couponDiscountTitle,
    this.paymentStatus,
    this.orderStatus,
    this.totalTaxAmount,
    this.paymentMethod,
    this.transactionReference,
    this.deliveryAddressId,
    this.createdAt,
    this.updatedAt,
    this.checked,
    this.deliveryManId,
    this.deliveryCharge,
    this.orderNote,
    this.couponCode,
    this.orderType,
    this.branchId,
    this.timeSlotId,
    this.date,
    this.deliveryDate,
    this.callback,
    this.productId,
    this.quantity,
    this.code,
    this.detailsCount,
    this.customer,
    this.deliveryMan,
  });

  int? id;
  int? userId;
  int? orderAmount;
  int? couponDiscountAmount;
  dynamic couponDiscountTitle;
  String? paymentStatus;
  String? orderStatus;
  int? totalTaxAmount;
  String? paymentMethod;
  dynamic transactionReference;
  int? deliveryAddressId;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? checked;
  dynamic deliveryManId;
  int? deliveryCharge;
  String? orderNote;
  dynamic couponCode;
  String? orderType;
  int? branchId;
  int? timeSlotId;
  DateTime? date;
  DateTime? deliveryDate;
  dynamic callback;
  String? productId;
  String? quantity;
  String? code;
  int? detailsCount;
  Customer? customer;
  dynamic deliveryMan;

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json["id"],
        userId: json["user_id"],
        orderAmount: json["order_amount"],
        couponDiscountAmount: json["coupon_discount_amount"],
        couponDiscountTitle: json["coupon_discount_title"],
        paymentStatus: json["payment_status"],
        orderStatus: json["order_status"],
        totalTaxAmount: json["total_tax_amount"],
        paymentMethod: json["payment_method"],
        transactionReference: json["transaction_reference"],
        deliveryAddressId: json["delivery_address_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        checked: json["checked"],
        deliveryManId: json["delivery_man_id"],
        deliveryCharge: json["delivery_charge"],
        orderNote: json["order_note"],
        couponCode: json["coupon_code"],
        orderType: json["order_type"],
        branchId: json["branch_id"],
        timeSlotId: json["time_slot_id"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        deliveryDate: json["delivery_date"] == null
            ? null
            : DateTime.parse(json["delivery_date"]),
        callback: json["callback"],
        productId: json["product_id"],
        quantity: json["quantity"],
        code: json["code"],
        detailsCount: json["details_count"],
        customer: json["customer"] == null
            ? null
            : Customer.fromJson(json["customer"]),
        deliveryMan: json["delivery_man"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "order_amount": orderAmount,
        "coupon_discount_amount": couponDiscountAmount,
        "coupon_discount_title": couponDiscountTitle,
        "payment_status": paymentStatus,
        "order_status": orderStatus,
        "total_tax_amount": totalTaxAmount,
        "payment_method": paymentMethod,
        "transaction_reference": transactionReference,
        "delivery_address_id": deliveryAddressId,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "checked": checked,
        "delivery_man_id": deliveryManId,
        "delivery_charge": deliveryCharge,
        "order_note": orderNote,
        "coupon_code": couponCode,
        "order_type": orderType,
        "branch_id": branchId,
        "time_slot_id": timeSlotId,
        "date": date == null ? null : date!.toIso8601String(),
        "delivery_date": deliveryDate == null
            ? null
            : "${deliveryDate!.year.toString().padLeft(4, '0')}-${deliveryDate!.month.toString().padLeft(2, '0')}-${deliveryDate!.day.toString().padLeft(2, '0')}",
        "callback": callback,
        "product_id": productId,
        "quantity": quantity,
        "code": code,
        "details_count": detailsCount,
        "customer": customer == null ? null : customer!.toJson(),
        "delivery_man": deliveryMan,
      };
}

class Customer {
  Customer({
    this.id,
    this.name,
    this.email,
    this.verificationAt,
    this.avatar,
    this.phone,
    this.image,
    this.postalCode,
    this.createdAt,
    this.updatedAt,
    this.otpCode,
    this.verified,
  });

  int? id;
  String? name;
  String? email;
  DateTime? verificationAt;
  dynamic avatar;
  String? phone;
  dynamic image;
  dynamic postalCode;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? otpCode;
  String? verified;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        verificationAt: json["verification_at"] == null
            ? null
            : DateTime.parse(json["verification_at"]),
        avatar: json["avatar"],
        phone: json["phone"],
        image: json["image"],
        postalCode: json["postal_code"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        otpCode: json["otp_code"],
        verified: json["verified"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "verification_at":
            verificationAt == null ? null : verificationAt!.toIso8601String(),
        "avatar": avatar,
        "phone": phone,
        "image": image,
        "postal_code": postalCode,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "otp_code": otpCode,
        "verified": verified,
      };
}
