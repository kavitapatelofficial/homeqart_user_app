// To parse this JSON data, do
//
//     final addressModel = addressModelFromJson(jsonString);

import 'dart:convert';

List<AddressModel> addressModelFromJson(String str) => List<AddressModel>.from(
    json.decode(str).map((x) => AddressModel.fromJson(x)));

String addressModelToJson(List<AddressModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AddressModel {
  AddressModel({
    this.id,
    this.address,
    this.pinCode,
    this.city,
    this.country,
    this.phone,
  });

  int? id;
  String? address;
  int? pinCode;
  String? city;
  String? country;
  String? phone;

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        id: json["id"],
        address: json["address"],
        pinCode: json["pin_code"],
        city: json["city"],
        country: json["country"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "address": address,
        "pin_code": pinCode,
        "city": city,
        "country": country,
        "phone": phone,
      };
}
