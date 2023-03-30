import 'package:vgp_cliente/app/domain/repositories/login.repository.dart';

class GetLoginUC {
  GetLoginUC(this.courseRepository);
  final LoginRepository courseRepository;

  GetLoginFuture call(String email, String password) async {
    return courseRepository.getLogin(email, password);
  }
}
