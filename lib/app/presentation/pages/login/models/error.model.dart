// To parse this JSON data, do
//
//     final error = errorFromJson(jsonString);
import 'dart:convert';

Error errorFromJson(String str) => Error.fromJson(json.decode(str));

String errorToJson(Error data) => json.encode(data.toJson());

class Error {
  Error({
    required this.statusCode,
    required this.message,
    required this.error,
  });

  int statusCode;
  List<String> message;
  String error;

  factory Error.fromJson(Map<String, dynamic> json) => Error(
        statusCode: json["statusCode"],
        message: List<String>.from(json["message"].map((x) => x)),
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": List<dynamic>.from(message.map((x) => x)),
        "error": error,
      };
}
