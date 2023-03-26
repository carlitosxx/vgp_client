import 'package:vgp_cliente/app/core/either/either.dart';
import '../../core/errors/http_request_failure.dart';
import '../entities/course.entity.dart';

typedef GetCourseFuture = Future<Either<HttpRequestFailure, Course>>;

abstract class CourseRepository {
  GetCourseFuture getCourse(String courseId);
}
