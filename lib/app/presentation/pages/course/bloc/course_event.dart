part of 'course_bloc.dart';

// @freezed
// class CourseEvent with _$CourseEvent {
//   const factory CourseEvent.started() = _Started;
// }
abstract class CourseEvent extends Equatable {
  const CourseEvent();
}

class LoadCourseEvent extends CourseEvent {
  const LoadCourseEvent(this.courseId);
  final String courseId;
  // final String userID;
  @override
  List<Object?> get props => throw UnimplementedError();
}
