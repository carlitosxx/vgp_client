// To parse this JSON data, do
//
//     final responseGetStudentByEmailAndPassword = responseGetStudentByEmailAndPasswordFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ResponseGetStudentByEmailAndPassword responseGetStudentByEmailAndPasswordFromJson(String str) => ResponseGetStudentByEmailAndPassword.fromJson(json.decode(str));

String responseGetStudentByEmailAndPasswordToJson(ResponseGetStudentByEmailAndPassword data) => json.encode(data.toJson());

class ResponseGetStudentByEmailAndPassword {
    ResponseGetStudentByEmailAndPassword({
        required this.data,
    });

    Data data;

    factory ResponseGetStudentByEmailAndPassword.fromJson(Map<String, dynamic> json) => ResponseGetStudentByEmailAndPassword(
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
    };
}

class Data {
    Data({
        required this.id,
        required this.email,
        required this.profile,
        required this.token,
    });

    String id;
    String email;
    Profile profile;
    String token;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        email: json["email"],
        profile: Profile.fromJson(json["profile"]),
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "profile": profile.toJson(),
        "token": token,
    };
}

class Profile {
    Profile({
        required this.id,
        required this.dateOfBirth,
        required this.isMale,
        required this.urlImage,
        required this.personalNumber,
        required this.experience,
    });

    String id;
    DateTime dateOfBirth;
    bool isMale;
    String urlImage;
    String personalNumber;
    int experience;

    factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json["id"],
        dateOfBirth: DateTime.parse(json["date_of_birth"]),
        isMale: json["is_male"],
        urlImage: json["url_image"],
        personalNumber: json["personal_number"],
        experience: json["experience"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "date_of_birth": "${dateOfBirth.year.toString().padLeft(4, '0')}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}",
        "is_male": isMale,
        "url_image": urlImage,
        "personal_number": personalNumber,
        "experience": experience,
    };
}
