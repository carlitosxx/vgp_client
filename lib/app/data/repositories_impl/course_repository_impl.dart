// import 'package:vgp_cliente/app/data/datasource/remote/course.datasource.dart';
import 'package:vgp_cliente/app/domain/repositories/course_repository.dart';

import '../datasource/remote/course.datasource.dart';

class CourseRepositoryImpl implements CourseRepository {
  final CourseDataSource _courseDataSource;
  CourseRepositoryImpl(this._courseDataSource);

  @override
  GetCourseFuture getCourse(String courseId) {
    return _courseDataSource.getCourse(courseId);
  }
}
