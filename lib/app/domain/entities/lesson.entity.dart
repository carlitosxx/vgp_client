import 'package:equatable/equatable.dart';

import 'progress-lesson.entity.dart';

class Lesson extends Equatable {
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

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        image,
        video,
        order,
        isActive,
        amountExperience,
        progressLesson
      ];
}
