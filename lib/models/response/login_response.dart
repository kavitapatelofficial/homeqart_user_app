// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    this.result,
    this.message,
    this.accessToken,
    this.tokenType,
    this.expiresAt,
    this.user,
  });

  bool? result;
  String? message;
  String? accessToken;
  String? tokenType;
  DateTime? expiresAt;
  User? user;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        result: json["result"],
        message: json["message"],
        accessToken: json["access_token"],
        tokenType: json["token_type"],
        expiresAt: json["expires_at"] == null
            ? null
            : DateTime.parse(json["expires_at"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "access_token": accessToken,
        "token_type": tokenType,
        "expires_at": expiresAt == null ? null : expiresAt!.toIso8601String(),
        "user": user == null ? null : user!.toJson(),
      };
}

class User {
  User({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.image,
  });

  int? id;
  String? name;
  String? email;
  String? phone;
  dynamic image;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "image": image,
      };
}
