part of 'login_bloc.dart';

abstract class LoginState extends Equatable {}

class LoginInitialState extends LoginState {
  @override
  List<Object?> get props => [];
}

//todo: loading state
class LoginLoadingState extends LoginState {
  @override
  List<Object?> get props => [];
}

//todo: loaded state
class LoginLoadedState extends LoginState {
  final Login login;
  LoginLoadedState(this.login);

  @override
  List<Object?> get props => [login];
}

//todo: error state
class LoginErrorState extends LoginState {
  final String error;
  LoginErrorState(this.error);
  @override
  List<Object?> get props => [error];
}
