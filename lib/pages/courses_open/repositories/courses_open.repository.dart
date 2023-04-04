import 'package:dio/dio.dart';
import 'package:vgp_cliente/pages/courses_open/models/course_open.model.dart';

import '../../../app/core/constants/environment.dart';

class CoursesOpenRepository {
  Future<List<CourseOpen>> getCoursesOpenByCategoryId(
      {required String categoryId}) async {
    String url = "${Environment.apiUrl}course-open/$categoryId";
    Response<dynamic> response = await Dio().get(url);
    // print(response);
    if (response.statusCode == 200) {
      print('pase por 200');
      List listCoursesOpenRaw = (response.data)['data'];
      print(listCoursesOpenRaw);
      try {
        List<CourseOpen> listCoursesOpen = listCoursesOpenRaw.map((e) {
          // print(e.length);
          return CourseOpen.fromJson(e);
        }).toList();
        print('pase por la serializacion');
        print(listCoursesOpen);
        return listCoursesOpen;
      } catch (e) {
        print(e);
      }
      throw Exception('error');
    } else {
      throw Exception('error');
    }
  }
}
