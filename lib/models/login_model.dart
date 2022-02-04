// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    required this.email,
    required this.password,
  });

  String email;
  String password;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}

// To parse this JSON data, do
//
//     final successLoginModel = successLoginModelFromJson(jsonString);

StatusLoginModel successLoginModelFromJson(String str) =>
    StatusLoginModel.fromJson(json.decode(str));

String successLoginModelToJson(StatusLoginModel data) =>
    json.encode(data.toJson());

class StatusLoginModel {
  StatusLoginModel({required this.message, required this.status});

  String message;
  bool status;

  factory StatusLoginModel.fromJson(Map<String, dynamic> json) =>
      StatusLoginModel(
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
      };
}
