import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:vgp_cliente/app/core/constants/environment.dart';
import 'package:vgp_cliente/app/core/either/either.dart';
import 'package:vgp_cliente/app/core/errors/http_request_failure.dart';
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
      FlutterSecureStorage secureStorage = const FlutterSecureStorage();
      String url = "${Environment.apiUrl}auth/login";
      Map<String, dynamic> data = {"email": email, "password": password};
      final response = await dio.post(url, data: data);
      if (response.statusCode == 201) {
        final login = LoginModel.fromJson(response.data);
        secureStorage.write(key: 'token', value: login.token);
        print(login);
        return Either.right(
          login,
        );
      } else {
        return Either.left(
          HttpRequestFailure.badRequest(),
        );
      }
    } on DioError catch (e) {
      // print(e);
      late HttpRequestFailure failure;
      if (e.type == DioErrorType.response) {
        if (e.response!.statusCode == 400) {
          failure = HttpRequestFailure.notFound();
        }
        if (e.response!.statusCode == 404) {
          failure = HttpRequestFailure.notFound();
        } else if (e.response!.statusCode == 401) {
          failure = HttpRequestFailure.unauthorized();
        } else if (e.response!.statusCode! >= 500) {
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
      // print(e);
      return Either.left(
        HttpRequestFailure.local(),
      );
    }
  }
}
