import 'package:dio/dio.dart';
import 'package:vgp_cliente/app/core/constants/environment.dart';
import 'package:vgp_cliente/app/core/either/either.dart';
import 'package:vgp_cliente/app/core/errors/http_request_failure.dart';
import 'package:vgp_cliente/app/core/utils/catch_dio_error.dart';
import 'package:vgp_cliente/app/data/models/login/login.model.dart';
import 'package:vgp_cliente/app/domain/repositories/login.repository.dart';

abstract class LoginDataSource {
  GetLoginFuture getLogin(String email, String password);
}

class LoginDataSourceImpl implements LoginDataSource {
  final Dio dio;
  LoginDataSourceImpl(this.dio);

  @override
  GetLoginFuture getLogin(String email, String password) async {
    try {
      String url = "${Environment.apiUrl}auth/login";
      Map<String, dynamic> data = {"email": email, "password": password};
      final response = await dio.post(url, data: data);
      if (response.statusCode == 201) {
        final login = LoginModel.fromJson(response.data);
        return Either.right(
          login,
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
