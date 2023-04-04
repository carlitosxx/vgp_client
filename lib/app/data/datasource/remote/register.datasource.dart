import 'package:dio/dio.dart';
import 'package:vgp_cliente/app/core/constants/environment.dart';
import 'package:vgp_cliente/app/core/either/either.dart';
import 'package:vgp_cliente/app/core/errors/http_request_failure.dart';
import 'package:vgp_cliente/app/core/utils/catch_dio_error.dart';
import 'package:vgp_cliente/app/data/models/register/register.model.dart';
import 'package:vgp_cliente/app/domain/repositories/register.repository.dart';

abstract class RegisterDataSource {
  GetRegisterFuture getRegister(
      String firstName, String lastName, String email, String password);
}

class RegisterDataSourceImpl implements RegisterDataSource {
  final Dio dio;
  RegisterDataSourceImpl(this.dio);

  @override
  GetRegisterFuture getRegister(
      String firstName, String lastName, String email, String password) async {
    try {
      String url = "${Environment.apiUrl}auth/register";
      Map<String, dynamic> data = {
        "email": email,
        "password": password,
        "first_name": firstName,
        "last_name": lastName
      };
      final response = await dio.post(url, data: data);
      if (response.statusCode == 201) {
        final login = RegisterModel.fromJson(response.data);
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
