part of 'login_bloc.dart';

@immutable
abstract class LoginState {
  final bool isValidAccount;
  final String dataAccount;

  const LoginState({
     this.isValidAccount=false,
     this.dataAccount='',});
}

class LoginInitial extends LoginState {
  const LoginInitial({
     super.isValidAccount,
      super.dataAccount});
}
