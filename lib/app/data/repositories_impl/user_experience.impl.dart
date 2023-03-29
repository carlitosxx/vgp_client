import 'package:vgp_cliente/app/data/datasource/remote/user-experience.datasource.dart';
import 'package:vgp_cliente/app/domain/repositories/user-experience.repository.dart';

class UserExperienceRepositoryImpl implements UserExperienceRepository {
  final UserExperienceDataSource _userExperienceDataSource;
  UserExperienceRepositoryImpl(this._userExperienceDataSource);

  @override
  GetUserAndExperienceFuture getUserAndExperience() {
    return _userExperienceDataSource.getUserAndExperience();
  }
}
