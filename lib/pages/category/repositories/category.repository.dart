import 'package:dio/dio.dart';
import '../models/category.model.dart';
import '../../../app/core/constants/environment.dart';

class CategoryRepository {
  String url = "${Environment.apiUrl}category";
  Future<Map<String, dynamic>> getAllActiveCategory() async {
    Response<dynamic> response = await Dio().get(url);
    if (response.statusCode == 200) {
      List listCategoryRaw = (response.data)['data'];
      var urlHost = (response.data)['url_host'];
      var listCategory =
          listCategoryRaw.map((e) => Category.fromJson(e)).toList();
      Map<String, dynamic> responseComplete = {
        "url_host": urlHost,
        "data": listCategory
      };
      return responseComplete;
    } else {
      throw Exception('error');
    }
  }
}
