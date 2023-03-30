import 'package:vgp_cliente/app/data/datasource/remote/login.datasource.dart';
import 'package:vgp_cliente/app/domain/repositories/login.repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginDataSource _loginDataSource;
  LoginRepositoryImpl(this._loginDataSource);

  @override
  GetLoginFuture getLogin(String email, String password) {
    return _loginDataSource.getLogin(email, password);
  }
}
