import 'package:vgp_cliente/app/core/either/either.dart';
import 'package:vgp_cliente/app/core/errors/http_request_failure.dart';
import 'package:vgp_cliente/app/domain/entities/login/login.entity.dart';

typedef GetLoginFuture = Future<Either<HttpRequestFailure, Login>>;

abstract class LoginRepository {
  GetLoginFuture getLogin(String email, String password);
}
