part of 'course_bloc.dart';

abstract class CourseEvent extends Equatable {
  const CourseEvent();
}

class LoadCourseEvent extends CourseEvent {
  const LoadCourseEvent(this.courseId);
  final String courseId;
  @override
  List<Object?> get props => [courseId];
}
