// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

import 'package:vgp_cliente/app/domain/entities/login/login.entity.dart';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel extends Login {
  const LoginModel({
    required this.token,
  }) : super(token: token);

  final String token;

  LoginModel copyWith({
    String? token,
  }) =>
      LoginModel(
        token: token ?? this.token,
      );

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
      };
}
