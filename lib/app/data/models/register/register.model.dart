// To parse this JSON data, do
//
//     final registerModel = registerModelFromJson(jsonString);

import 'dart:convert';

import 'package:vgp_cliente/app/domain/entities/register/register.entity.dart';

RegisterModel registerModelFromJson(String str) =>
    RegisterModel.fromJson(json.decode(str));

String registerModelToJson(RegisterModel data) => json.encode(data.toJson());

class RegisterModel extends Register {
  const RegisterModel({
    required this.token,
  }) : super(token: token);

  final String token;

  RegisterModel copyWith({
    String? token,
  }) =>
      RegisterModel(
        token: token ?? this.token,
      );

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
      };
}
