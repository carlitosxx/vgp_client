import 'package:vgp_cliente/app/domain/repositories/user-experience.repository.dart';

class GetUserAndExperienceUC {
  GetUserAndExperienceUC(this.userExperienceRepository);
  final UserExperienceRepository userExperienceRepository;

  GetUserAndExperienceFuture call() async {
    return userExperienceRepository.getUserAndExperience();
  }
}
