part of 'courses_open_bloc.dart';

abstract class CoursesOpenState extends Equatable {}

//todo: loading state
class CoursesOpenLoadingState extends CoursesOpenState {
  @override  
  List<Object?> get props => [];
}
//todo: loaded state
class CoursesOpenLoadedState extends CoursesOpenState {
  final List<CourseOpen> listCoursesOpen;
  CoursesOpenLoadedState(this.listCoursesOpen);

  @override 
  List<Object?> get props => [listCoursesOpen];
}
//todo: error state
class CoursesOpenErrorState extends CoursesOpenState {
  final String error;
  CoursesOpenErrorState(this.error);
  @override  
  List<Object?> get props => [];
}