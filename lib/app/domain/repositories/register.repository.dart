import 'package:vgp_cliente/app/core/either/either.dart';
import 'package:vgp_cliente/app/core/errors/http_request_failure.dart';
import 'package:vgp_cliente/app/domain/entities/register/register.entity.dart';

typedef GetRegisterFuture = Future<Either<HttpRequestFailure, Register>>;

abstract class RegisterRepository {
  GetRegisterFuture getRegister(
      String firstName, String lastName, String email, String password);
}
