import 'package:vgp_cliente/app/domain/repositories/course.repository.dart';

class GetCourseUC {
  GetCourseUC(this.courseRepository);
  final CourseRepository courseRepository;

  GetCourseFuture call(String courseId) async {
    return courseRepository.getCourse(courseId);
  }
}
