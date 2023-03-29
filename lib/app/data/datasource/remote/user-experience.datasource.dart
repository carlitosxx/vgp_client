import 'package:dio/dio.dart';
import 'package:vgp_cliente/app/core/either/either.dart';
import 'package:vgp_cliente/app/core/errors/http_request_failure.dart';
import 'package:vgp_cliente/app/data/models/user_experience/user-experience.model.dart';
import 'package:vgp_cliente/app/domain/repositories/user-experience.repository.dart';
import 'package:vgp_cliente/environment/environment.dart';
import 'package:vgp_cliente/utils/dio_token_interceptor.dart';

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
          HttpRequestFailure.badRequest(),
        );
      }
    } on DioError catch (e) {
      late HttpRequestFailure failure;
      if (e.type == DioErrorType.response) {
        if (e.response!.statusCode == 404) {
          failure = HttpRequestFailure.notFound();
        } else if (e.response!.statusCode == 401) {
          failure = HttpRequestFailure.unauthorized();
        } else if (e.response!.statusCode == 500) {
          failure = HttpRequestFailure.server();
        }
      } else if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.receiveTimeout) {
        failure = HttpRequestFailure.network();
      } else {
        failure = HttpRequestFailure.badRequest();
      }
      return Either.left(
        failure,
      );
    } catch (e) {
      return Either.left(
        HttpRequestFailure.local(),
      );
    }
  }
}
