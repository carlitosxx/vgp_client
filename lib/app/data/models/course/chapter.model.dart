import 'package:vgp_cliente/app/domain/entities/course/chapter.entity.dart';

import 'lesson.model.dart';

class ChapterModel extends Chapter {
  const ChapterModel({
    required this.id,
    required this.name,
    this.description,
    this.image,
    required this.order,
    required this.isActive,
    required this.lesson,
  }) : super(
            id: id,
            name: name,
            description: description,
            image: image,
            order: order,
            isActive: isActive,
            lesson: lesson);

  final String id;
  final String name;
  final String? description;
  final String? image;
  final int order;
  final bool isActive;
  final List<LessonModel> lesson;

  ChapterModel copyWith({
    String? id,
    String? name,
    String? description,
    String? image,
    int? order,
    bool? isActive,
    List<LessonModel>? lesson,
  }) =>
      ChapterModel(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        image: image ?? this.image,
        order: order ?? this.order,
        isActive: isActive ?? this.isActive,
        lesson: lesson ?? this.lesson,
      );

  factory ChapterModel.fromJson(Map<String, dynamic> json) => ChapterModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        image: json["image"],
        order: json["order"],
        isActive: json["is_active"],
        lesson: List<LessonModel>.from(
            json["lesson"].map((x) => LessonModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "image": image,
        "order": order,
        "is_active": isActive,
        "lesson": List<dynamic>.from(lesson.map((x) => x.toJson())),
      };
}
