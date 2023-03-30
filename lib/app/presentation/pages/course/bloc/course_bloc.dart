import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vgp_cliente/app/core/utils/map-failure-to-string.util.dart';
import 'package:vgp_cliente/app/domain/entities/course/course.entity.dart';
import 'package:vgp_cliente/app/domain/usecases/get-course.usecase.dart';

part 'course_event.dart';
part 'course_state.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  final GetCourseUC _getCourseUC;

  CourseBloc(this._getCourseUC) : super(CourseLoadingState()) {
    on<LoadCourseEvent>((event, emit) async {
      emit(CourseLoadingState());
      final course = await _getCourseUC(event.courseId);
      course.when(
          left: (failure) =>
              emit(CourseErrorState(mapFailureToString(failure))),
          right: (course) => emit(CourseLoadedState(course)));
    });
  }
}
