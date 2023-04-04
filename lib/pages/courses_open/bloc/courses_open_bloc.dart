import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vgp_cliente/pages/courses_open/repositories/courses_open.repository.dart';
import '../models/course_open.model.dart';

part 'courses_open_event.dart';
part 'courses_open_state.dart';

class CoursesOpenBloc extends Bloc<CoursesOpenEvent, CoursesOpenState> {
  final CoursesOpenRepository _coursesOpenRepository;
  CoursesOpenBloc(this._coursesOpenRepository)
      : super(CoursesOpenLoadingState()) {
    on<LoadCoursesOpenEvent>((event, emit) async {
      emit(CoursesOpenLoadingState());
      try {
        final coursesOpen = await _coursesOpenRepository
            .getCoursesOpenByCategoryId(categoryId: event.categoryId);
        emit(CoursesOpenLoadedState(coursesOpen));
      } catch (e) {
        print(e);
        emit(CoursesOpenErrorState(e.toString()));
      }
    });
  }
}
