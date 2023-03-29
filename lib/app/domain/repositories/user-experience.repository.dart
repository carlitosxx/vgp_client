import 'package:vgp_cliente/app/core/either/either.dart';
import 'package:vgp_cliente/app/core/errors/http_request_failure.dart';
import 'package:vgp_cliente/app/domain/entities/user_experience/user-experience.entity.dart';

typedef GetUserAndExperienceFuture
    = Future<Either<HttpRequestFailure, UserExperience>>;

abstract class UserExperienceRepository {
  GetUserAndExperienceFuture getUserAndExperience();
}
