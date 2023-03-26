part of 'course_bloc.dart';

// @freezed
// class CourseState with _$CourseState {
//   const factory CourseState.initial() = _Initial;
// }

abstract class CourseState extends Equatable {}

//todo: loading state
class CourseLoadingState extends CourseState {
  @override
  List<Object?> get props => [];
}

//todo: loaded state
class CourseLoadedState extends CourseState {
  final Course course;
  CourseLoadedState(this.course);

  @override
  List<Object?> get props => [course];
}

//todo: error state
class CourseErrorState extends CourseState {
  final String error;
  CourseErrorState(this.error);
  @override
  List<Object?> get props => [error];
}
