part of 'user_experience.bloc.dart';

abstract class UserExperienceEvent extends Equatable {
  const UserExperienceEvent();
}

class LoadUserExperienceEvent extends UserExperienceEvent {
  const LoadUserExperienceEvent();
  @override
  List<Object?> get props => [];
}
