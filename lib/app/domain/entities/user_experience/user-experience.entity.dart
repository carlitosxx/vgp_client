import 'package:equatable/equatable.dart';

class UserExperience extends Equatable {
  const UserExperience({
    required this.experience,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.isMale,
    required this.urlImage,
  });

  final int experience;
  final String firstName;
  final String lastName;
  final String email;
  final bool isMale;
  final String urlImage;

  @override
  List<Object?> get props => [
        experience,
        firstName,
        lastName,
        email,
        isMale,
        urlImage,
      ];
}
