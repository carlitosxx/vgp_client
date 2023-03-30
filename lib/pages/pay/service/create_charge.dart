import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:vgp_cliente/app/core/constants/environment.dart';
import 'package:vgp_cliente/app/core/utils/dio_token_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:vgp_cliente/app/core/utils/show_dialog.dart';

void createCharge({
  required String email,
  required Response response,
  required String courseOpenId,
  required String price,
  required BuildContext context,
}) async {
  NavigatorState navigator = Navigator.of(context);
  try {
    String urlPayCreditCard = "${Environment.apiUrl}enroll/pay-credit-card";
    final dio = Dio();
    dio.interceptors.add(DioTokenInterceptor());
    Map<String, dynamic> data = json.decode(response.toString());
    Map<String, dynamic> body = {
      "courseOpen": courseOpenId,
      "price": price,
      "token": data["id"],
      "email": email
    };
    Response responseBackend = await dio.post(urlPayCreditCard, data: body);
    if (responseBackend.statusCode == 201) {
      navigator.pop();

      if (context.mounted) {
        Navigator.of(context).pushReplacementNamed("/home");
      }
    }
  } on DioError catch (e) {
    if (e.type == DioErrorType.response) {
      switch (e.response!.statusCode) {
        case 400:
          navigator.pop(context);
          Map<String, dynamic> messageError =
              json.decode(e.response.toString());
          showDialogAlert(
              context: context, message: messageError["message"], seconds: 5);
          break;
        case 401:
          navigator.pop(context);
          Map<String, dynamic> messageError =
              json.decode(e.response.toString());
          showDialogAlert(
              context: context, message: messageError["message"], seconds: 5);
          break;
        case 500:
          navigator.pop(context);
          showDialogAlert(
              context: context, message: 'Error de servidor', seconds: 5);

          break;
      }
    }
  }
}
