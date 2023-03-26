import 'package:dio/dio.dart';
import 'package:vgp_cliente/pages/home/models/course.model.dart';
import '/environment/environment.dart';

class CourseRepository {
  getCourseByIdAndUserId(
      {required String courseId, required String userId}) async {
    String url = "${Environment.apiUrl}/course/$courseId/$userId";
    Response<dynamic> response = await Dio().get(url);
    if (response.statusCode == 200) {
      final Course course = courseFromJson((response.data)['data']);
      return course;
    }
  }
}
