import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:vgp_cliente/pages/pay/service/create_charge.dart';
import 'package:vgp_cliente/utils/dio_token_interceptor.dart';
import 'package:vgp_cliente/utils/show_dialog.dart';
import 'dart:convert';
import '/environment/environment.dart';

void getTokenCreditCard(
    {required BuildContext context,
    required String numberCard,
    required String expiryDate,
    required String cvv,
    required String email,
    required String courseOpenId,
    required String price}) async {
  NavigatorState navigator = Navigator.of(context);
  try {
    List<String> expiryDateList = expiryDate.split('/');
    if (numberCard.isEmpty ||
        expiryDate.isEmpty ||
        cvv.isEmpty ||
        email.isEmpty ||
        expiryDateList.length != 2) {
      navigator.pop();
      showDialogAlert(
          context: context,
          message: "Porfavor verifique todos los campos",
          seconds: 3);
      return;
    }
    String month = expiryDate.split('/')[0];
    String year = expiryDate.split('/')[1];
    numberCard = numberCard.replaceAll(" ", "");
    String url = "https://secure.culqi.com/v2/tokens";
    Map<String, dynamic> body = {
      "card_number": numberCard,
      "cvv": cvv,
      "expiration_month": month,
      "expiration_year": "20$year",
      "email": email,
    };
    Response<dynamic> response = await Dio().post(url,
        data: body,
        options: Options(
            headers: {"Authorization": "Bearer pk_test_CVhb8zLkUA9dmTzi"}));
    if (response.statusCode == 201) {
      if (context.mounted) {
        createCharge(
            email: email,
            response: response,
            context: context,
            courseOpenId: courseOpenId,
            price: price);
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
              context: context,
              message: messageError["user_message"],
              seconds: 5);
          break;
        case 401:
          navigator.pop(context);
          showDialogAlert(
              context: context,
              message: 'No estas autorizado para esta accion',
              seconds: 5);

          break;
        case 500:
          navigator.pop(context);
          showDialogAlert(
              context: context,
              message: 'Hubo un problema con el servidor',
              seconds: 5);
          break;
      }
    }
  }
}
