import 'package:equatable/equatable.dart';

class Login extends Equatable {
  const Login({
    required this.token,
  });

  final String token;

  @override
  List<Object?> get props => [token];
}
