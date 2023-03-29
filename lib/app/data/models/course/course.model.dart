// To parse this JSON data, do
//
//     final course = courseFromJson(jsonString);

import 'dart:convert';

import 'package:vgp_cliente/app/data/models/course/chapter.model.dart';
import 'package:vgp_cliente/app/domain/entities/course/course.entity.dart';

CourseModel courseModelFromJson(String str) =>
    CourseModel.fromJson(json.decode(str));

String courseModelToJson(CourseModel data) => json.encode(data.toJson());

class CourseModel extends Course {
  const CourseModel({
    required this.id,
    required this.name,
    this.description,
    this.image,
    required this.createdAt,
    required this.updateAt,
    required this.chapter,
  }) : super(
            id: id,
            name: name,
            description: description,
            image: image,
            createdAt: createdAt,
            updateAt: updateAt,
            chapter: chapter);

  final String id;
  final String name;
  final String? description;
  final String? image;
  final DateTime createdAt;
  final DateTime updateAt;
  final List<ChapterModel> chapter;

  CourseModel copyWith({
    String? id,
    String? name,
    String? description,
    String? image,
    DateTime? createdAt,
    DateTime? updateAt,
    List<ChapterModel>? chapter,
  }) =>
      CourseModel(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        image: image ?? this.image,
        createdAt: createdAt ?? this.createdAt,
        updateAt: updateAt ?? this.updateAt,
        chapter: chapter ?? this.chapter,
      );

  factory CourseModel.fromJson(Map<String, dynamic> json) => CourseModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        image: json["image"],
        createdAt: DateTime.parse(json["created_at"]),
        updateAt: DateTime.parse(json["update_at"]),
        chapter: List<ChapterModel>.from(
            json["chapter"].map((x) => ChapterModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "image": image,
        "created_at": createdAt.toIso8601String(),
        "update_at": updateAt.toIso8601String(),
        "chapter": List<dynamic>.from(chapter.map((x) => x.toJson())),
      };
}
