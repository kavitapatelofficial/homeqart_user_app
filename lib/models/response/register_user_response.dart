// To parse this JSON data, do
//
//     final registerUser = registerUserFromJson(jsonString);

import 'dart:convert';

RegisterUser registerUserFromJson(String str) =>
    RegisterUser.fromJson(json.decode(str));

String registerUserToJson(RegisterUser data) => json.encode(data.toJson());

class RegisterUser {
  RegisterUser({
    this.result,
    this.message,
    this.userId,
  });

  bool? result;
  String? message;
  int? userId;

  factory RegisterUser.fromJson(Map<String, dynamic> json) => RegisterUser(
        result: json["result"],
        message: json["message"],
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "user_id": userId,
      };
}
