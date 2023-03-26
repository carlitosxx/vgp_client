// To parse this JSON data, do
//
//     final course = courseFromJson(jsonString);

import 'dart:convert';

Course courseFromJson(String str) => Course.fromJson(json.decode(str));

String courseToJson(Course data) => json.encode(data.toJson());

class Course {
  Course({
    required this.id,
    required this.name,
    this.description,
    this.image,
    required this.createdAt,
    required this.updateAt,
    required this.chapter,
  });

  final String id;
  final String name;
  final String? description;
  final String? image;
  final DateTime createdAt;
  final DateTime updateAt;
  final List<Chapter> chapter;

  Course copyWith({
    String? id,
    String? name,
    String? description,
    String? image,
    DateTime? createdAt,
    DateTime? updateAt,
    List<Chapter>? chapter,
  }) =>
      Course(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        image: image ?? this.image,
        createdAt: createdAt ?? this.createdAt,
        updateAt: updateAt ?? this.updateAt,
        chapter: chapter ?? this.chapter,
      );

  factory Course.fromJson(Map<String, dynamic> json) => Course(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        image: json["image"],
        createdAt: DateTime.parse(json["created_at"]),
        updateAt: DateTime.parse(json["update_at"]),
        chapter:
            List<Chapter>.from(json["chapter"].map((x) => Chapter.fromJson(x))),
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

class Chapter {
  Chapter({
    required this.id,
    required this.name,
    this.description,
    this.image,
    required this.order,
    required this.isActive,
    required this.lesson,
  });

  final String id;
  final String name;
  final String? description;
  final String? image;
  final int order;
  final bool isActive;
  final List<Lesson> lesson;

  Chapter copyWith({
    String? id,
    String? name,
    String? description,
    String? image,
    int? order,
    bool? isActive,
    List<Lesson>? lesson,
  }) =>
      Chapter(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        image: image ?? this.image,
        order: order ?? this.order,
        isActive: isActive ?? this.isActive,
        lesson: lesson ?? this.lesson,
      );

  factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        image: json["image"],
        order: json["order"],
        isActive: json["is_active"],
        lesson:
            List<Lesson>.from(json["lesson"].map((x) => Lesson.fromJson(x))),
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

class Lesson {
  Lesson({
    required this.id,
    required this.name,
    this.description,
    this.image,
    this.video,
    required this.order,
    required this.isActive,
    required this.amountExperience,
    this.progressLesson,
  });

  final String id;
  final String name;
  final String? description;
  final String? image;
  final String? video;
  final int order;
  final bool isActive;
  final int amountExperience;
  final ProgressLesson? progressLesson;

  Lesson copyWith({
    String? id,
    String? name,
    String? description,
    String? image,
    String? video,
    int? order,
    bool? isActive,
    int? amountExperience,
    ProgressLesson? progressLesson,
  }) =>
      Lesson(
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

  factory Lesson.fromJson(Map<String, dynamic> json) => Lesson(
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
            : ProgressLesson.fromJson(json["progress_lesson"]),
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

class ProgressLesson {
  ProgressLesson({
    required this.id,
    required this.greenGem,
    required this.yellowGem,
    required this.redGem,
    required this.chaos,
  });

  final String id;
  final bool greenGem;
  final bool yellowGem;
  final bool redGem;
  final bool chaos;

  ProgressLesson copyWith({
    String? id,
    bool? greenGem,
    bool? yellowGem,
    bool? redGem,
    bool? chaos,
  }) =>
      ProgressLesson(
        id: id ?? this.id,
        greenGem: greenGem ?? this.greenGem,
        yellowGem: yellowGem ?? this.yellowGem,
        redGem: redGem ?? this.redGem,
        chaos: chaos ?? this.chaos,
      );

  factory ProgressLesson.fromJson(Map<String, dynamic> json) => ProgressLesson(
        id: json["id"],
        greenGem: json["green_gem"],
        yellowGem: json["yellow_gem"],
        redGem: json["red_gem"],
        chaos: json["chaos"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "green_gem": greenGem,
        "yellow_gem": yellowGem,
        "red_gem": redGem,
        "chaos": chaos,
      };
}
