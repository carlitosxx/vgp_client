import 'package:dio/dio.dart';
import 'package:vgp_cliente/app/core/either/either.dart';
import 'package:vgp_cliente/app/core/errors/http_request_failure.dart';
import 'package:vgp_cliente/app/core/utils/catch_dio_error.dart';
import 'package:vgp_cliente/app/data/models/user_experience/user-experience.model.dart';
import 'package:vgp_cliente/app/domain/repositories/user-experience.repository.dart';
import 'package:vgp_cliente/app/core/constants/environment.dart';
import 'package:vgp_cliente/app/core/utils/dio_token_interceptor.dart';

abstract class UserExperienceDataSource {
  GetUserAndExperienceFuture getUserAndExperience();
}

class UserExperienceDataSourceImpl implements UserExperienceDataSource {
  final Dio dio;
  UserExperienceDataSourceImpl(this.dio);

  @override
  GetUserAndExperienceFuture getUserAndExperience() async {
    try {
      String url =
          "${Environment.apiUrl}user/get-user-and-experience-by-userid";
      dio.interceptors.add(DioTokenInterceptor());
      final response = await dio.post(url);
      if (response.statusCode == 201) {
        final course = UserExperienceModel.fromJson(response.data);
        return Either.right(
          course,
        );
      } else {
        return Either.left(
          HttpRequestFailure.notFound(),
        );
      }
    } on DioError catch (e) {
      return Either.left(
        catchDioError(e),
      );
    } catch (e) {
      return Either.left(
        HttpRequestFailure.local(),
      );
    }
  }
}
