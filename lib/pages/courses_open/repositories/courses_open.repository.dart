import 'package:dio/dio.dart';
import 'package:vgp_cliente/pages/courses_open/models/course_open.model.dart';

import '/environment/environment.dart';

class CoursesOpenRepository{
  
  Future<List<CourseOpen>> getCoursesOpenByCategoryId({required String categoryId }) async{
    String url = "${Environment.apiUrl}course-open/$categoryId";
     Response<dynamic> response = await Dio().get(url);      
      if (response.statusCode == 200) {              
        List listCoursesOpenRaw = (response.data)['data'];           
        // var urlHost=(response.data)['url_host'];
        List<CourseOpen>  listCoursesOpen= listCoursesOpenRaw.map((e)=>CourseOpen.fromJson(e)).toList();
        return listCoursesOpen;
        // Map<String,dynamic> responseComplete={
        //   "url_host":urlHost,
        //   "data":listCategory
        // };   
        // return responseComplete; 
      }else{
        throw Exception('error');       
      }
  }
}