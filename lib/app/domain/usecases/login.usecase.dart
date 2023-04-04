import 'package:vgp_cliente/app/domain/repositories/login.repository.dart';

class GetLoginUC {
  GetLoginUC(this.loginRepository);
  final LoginRepository loginRepository;

  GetLoginFuture call(String email, String password) async {
    return loginRepository.getLogin(email, password);
  }
}
