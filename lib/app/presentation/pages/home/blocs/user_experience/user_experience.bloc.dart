import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vgp_cliente/app/core/utils/map-failure-to-string.util.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vgp_cliente/app/domain/entities/user_experience/user-experience.entity.dart';
import 'package:vgp_cliente/app/domain/usecases/user-experience.usecase.dart';

part 'user_experience.event.dart';
part 'user_experience.state.dart';

class UserExperienceBloc
    extends Bloc<UserExperienceEvent, UserExperienceState> {
  final GetUserAndExperienceUC _getUserAndExperienceUC;
  UserExperienceBloc(this._getUserAndExperienceUC)
      : super(UserExperienceLoadingState()) {
    on<LoadUserExperienceEvent>((event, emit) async {
      emit(UserExperienceLoadingState());
      final userExperience = await _getUserAndExperienceUC();
      userExperience.when(
          left: (failure) =>
              emit(UserExperienceErrorState(mapFailureToString(failure))),
          right: (course) => emit(UserExperienceLoadedState(course)));
    });
  }
}
