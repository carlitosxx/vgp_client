import 'package:equatable/equatable.dart';

import 'lesson.entity.dart';

class Chapter extends Equatable {
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

  @override
  List<Object?> get props =>
      [id, name, description, image, order, isActive, lesson];
}
