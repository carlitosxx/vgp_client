import 'package:vgp_cliente/app/core/either/either.dart';
import 'package:vgp_cliente/app/core/errors/http_request_failure.dart';
import 'package:vgp_cliente/app/data/datasource/local/save_token.datasource.dart';
import 'package:vgp_cliente/app/data/datasource/remote/register.datasource.dart';
import 'package:vgp_cliente/app/domain/entities/register/register.entity.dart';
import 'package:vgp_cliente/app/domain/repositories/register.repository.dart';

class RegisterRepositoryImpl implements RegisterRepository {
  final RegisterDataSource _registerDataSource;
  final TokenDataSource _tokenDataSource;
  RegisterRepositoryImpl(this._registerDataSource, this._tokenDataSource);

  @override
  GetRegisterFuture getRegister(
      String firstName, String lastName, String email, String password) async {
    GetRegisterFuture response =
        _registerDataSource.getRegister(firstName, lastName, email, password);
    Either<HttpRequestFailure, Register> value = await response;
    value.whenOrNull(right: (value) => _tokenDataSource.saveToken(value.token));
    return response;
  }
}
