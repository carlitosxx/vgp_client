import 'package:vgp_cliente/app/domain/entities/course/lesson.entity.dart';

import 'progress-lesson.model.dart';

class LessonModel extends Lesson {
  LessonModel({
    required this.id,
    required this.name,
    this.description,
    this.image,
    this.video,
    required this.order,
    required this.isActive,
    required this.amountExperience,
    this.progressLesson,
  }) : super(
            id: id,
            name: name,
            description: description,
            image: image,
            video: video,
            order: order,
            isActive: isActive,
            amountExperience: amountExperience,
            progressLesson: progressLesson);

  final String id;
  final String name;
  final String? description;
  final String? image;
  final String? video;
  final int order;
  final bool isActive;
  final int amountExperience;
  final ProgressLessonModel? progressLesson;

  LessonModel copyWith({
    String? id,
    String? name,
    String? description,
    String? image,
    String? video,
    int? order,
    bool? isActive,
    int? amountExperience,
    ProgressLessonModel? progressLesson,
  }) =>
      LessonModel(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        image: image ?? this.image,
        video: video ?? this.video,
        order: order ?? this.order,
        isActive: isActive ?? this.isActive,
        amountExperience: amountExperience ?? this.amountExperience,
        progressLesson: progressLesson ?? this.progressLesson,
      );

  factory LessonModel.fromJson(Map<String, dynamic> json) => LessonModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        image: json["image"],
        video: json["video"],
        order: json["order"],
        isActive: json["is_active"],
        amountExperience: json["amount_experience"],
        progressLesson: json["progress_lesson"] == null
            ? null
            : ProgressLessonModel.fromJson(json["progress_lesson"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "image": image,
        "video": video,
        "order": order,
        "is_active": isActive,
        "amount_experience": amountExperience,
        "progress_lesson": progressLesson?.toJson(),
      };
}
