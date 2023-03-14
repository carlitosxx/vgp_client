part of 'courses_open_bloc.dart';

abstract class CoursesOpenEvent extends Equatable {
  const CoursesOpenEvent();
}

class LoadCoursesOpenEvent extends CoursesOpenEvent {
  final String categoryId;
  const LoadCoursesOpenEvent(this.categoryId);
  @override
  List<Object?> get props => [categoryId];
}
