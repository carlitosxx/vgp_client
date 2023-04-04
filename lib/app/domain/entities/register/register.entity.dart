import 'package:equatable/equatable.dart';

class Register extends Equatable {
  const Register({
    required this.token,
  });

  final String token;

  @override
  List<Object?> get props => [token];
}
