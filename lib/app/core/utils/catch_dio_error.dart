import 'package:dio/dio.dart';
import 'package:vgp_cliente/app/core/errors/http_request_failure.dart';
import 'package:vgp_cliente/app/data/models/bad_request/bad-request.model.dart';

HttpRequestFailure catchDioError(DioError e) {
  late HttpRequestFailure failure;
  if (e.type == DioErrorType.response) {
    if (e.response!.statusCode == 400) {
      final badRequestModel = BadRequestModel.fromJson(e.response!.data);
      failure = HttpRequestFailure.badRequest(badRequestModel);
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
    failure = HttpRequestFailure.local();
  }
  return failure;
}
