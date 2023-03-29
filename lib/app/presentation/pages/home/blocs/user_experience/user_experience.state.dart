part of 'user_experience.bloc.dart';

abstract class UserExperienceState extends Equatable {}

//todo: loading state
class UserExperienceLoadingState extends UserExperienceState {
  @override
  List<Object?> get props => [];
}

//todo: loaded state
class UserExperienceLoadedState extends UserExperienceState {
  final UserExperience userExperience;
  UserExperienceLoadedState(this.userExperience);

  @override
  List<Object?> get props => [userExperience];
}

//todo: error state
class UserExperienceErrorState extends UserExperienceState {
  final String error;
  UserExperienceErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
