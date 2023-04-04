part of 'register_bloc.dart';

@freezed
class RegisterEvent with _$RegisterEvent {
  const factory RegisterEvent.started() = RegisterStarted;
  const factory RegisterEvent.load(
          String firstName, String lastName, String email, String password) =
      RegisterLoad;
  // const factory
}
