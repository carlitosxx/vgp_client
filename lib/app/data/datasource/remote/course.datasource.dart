import 'package:dio/dio.dart';
import 'package:vgp_cliente/app/core/either/either.dart';
import 'package:vgp_cliente/app/core/errors/http_request_failure.dart';
import 'package:vgp_cliente/app/data/models/course/course.model.dart';
import 'package:vgp_cliente/app/core/constants/environment.dart';
import 'package:vgp_cliente/app/domain/repositories/course.repository.dart';
import 'package:vgp_cliente/app/core/utils/dio_token_interceptor.dart';

abstract class CourseDataSource {
  GetCourseFuture getCourse(String courseId);
}

class CourseDataSourceImpl implements CourseDataSource {
  final Dio dio;
  CourseDataSourceImpl(this.dio);

  @override
  GetCourseFuture getCourse(String courseId) async {
    try {
      String url = "${Environment.apiUrl}course/$courseId";
      dio.interceptors.add(DioTokenInterceptor());
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        final course = CourseModel.fromJson(response.data);
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
