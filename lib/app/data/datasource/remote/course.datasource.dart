import 'package:dio/dio.dart';
import 'package:vgp_cliente/app/core/either/either.dart';
import 'package:vgp_cliente/app/core/errors/http_request_failure.dart';
import 'package:vgp_cliente/app/core/utils/catch_dio_error.dart';
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
