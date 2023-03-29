import 'package:equatable/equatable.dart';

import 'chapter.entity.dart';

class Course extends Equatable {
  const Course({
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

  @override
  List<Object?> get props =>
      [id, name, description, image, createdAt, updateAt, chapter];
}
