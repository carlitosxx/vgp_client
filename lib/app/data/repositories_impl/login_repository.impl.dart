import 'package:vgp_cliente/app/core/either/either.dart';
import 'package:vgp_cliente/app/core/errors/http_request_failure.dart';
import 'package:vgp_cliente/app/data/datasource/local/save_token.datasource.dart';
import 'package:vgp_cliente/app/data/datasource/remote/login.datasource.dart';
import 'package:vgp_cliente/app/domain/entities/login/login.entity.dart';
import 'package:vgp_cliente/app/domain/repositories/login.repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginDataSource _loginDataSource;
  final TokenDataSource _tokenDataSource;
  LoginRepositoryImpl(this._loginDataSource, this._tokenDataSource);

  @override
  GetLoginFuture getLogin(String email, String password) async {
    GetLoginFuture response = _loginDataSource.getLogin(email, password);
    Either<HttpRequestFailure, Login> value = await response;
    value.whenOrNull(right: (value) => _tokenDataSource.saveToken(value.token));
    return response;
  }
}
