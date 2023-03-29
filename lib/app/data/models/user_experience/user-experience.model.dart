// To parse this JSON data, do
//
//     final userExperienceModel = userExperienceModelFromJson(jsonString);

import 'dart:convert';

import 'package:vgp_cliente/app/domain/entities/user_experience/user-experience.entity.dart';

UserExperienceModel userExperienceModelFromJson(String str) =>
    UserExperienceModel.fromJson(json.decode(str));

String userExperienceModelToJson(UserExperienceModel data) =>
    json.encode(data.toJson());

class UserExperienceModel extends UserExperience {
  const UserExperienceModel({
    required this.experience,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.isMale,
    required this.urlImage,
  }) : super(
            experience: experience,
            firstName: firstName,
            lastName: lastName,
            email: email,
            isMale: isMale,
            urlImage: urlImage);

  final int experience;
  final String firstName;
  final String lastName;
  final String email;
  final bool isMale;
  final String urlImage;

  UserExperienceModel copyWith({
    int? experience,
    String? firstName,
    String? lastName,
    String? email,
    bool? isMale,
    String? urlImage,
  }) =>
      UserExperienceModel(
        experience: experience ?? this.experience,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        isMale: isMale ?? this.isMale,
        urlImage: urlImage ?? this.urlImage,
      );

  factory UserExperienceModel.fromJson(Map<String, dynamic> json) =>
      UserExperienceModel(
        experience: json["experience"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        isMale: json["is_male"],
        urlImage: json["url_image"],
      );

  Map<String, dynamic> toJson() => {
        "experience": experience,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "is_male": isMale,
        "url_image": urlImage,
      };
}
