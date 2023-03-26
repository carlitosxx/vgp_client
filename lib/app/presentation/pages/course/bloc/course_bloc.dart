import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vgp_cliente/app/core/errors/http_request_failure.dart';
import 'package:vgp_cliente/app/domain/entities/course.entity.dart';
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

String mapFailureToString(HttpRequestFailure failure) {
  return failure.when(
      network: () => 'Hubo un problema de red',
      notFound: () => 'No se encontro el recurso',
      server: () => 'Hubo un problema en el servidor',
      unauthorized: () => 'No estas autorizado',
      badRequest: () => 'La solicitud no puede ser procesado',
      local: () => 'Hubo un problema local o desconocido');
}
