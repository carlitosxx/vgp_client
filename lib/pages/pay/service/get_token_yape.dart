import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:vgp_cliente/pages/pay/service/create_charge.dart';
import 'package:vgp_cliente/utils/fix_price_culqi.dart';
import 'package:vgp_cliente/utils/show_dialog.dart';

void getTokenYape(
    {required BuildContext context,
    required String price,
    required String phone,
    required String codeOTP,
    required String courseOpenId,
    required String email}) async {
  NavigatorState navigator = Navigator.of(context);
  try {
    if (phone.isEmpty || codeOTP.isEmpty || price.isEmpty || email.isEmpty) {
      navigator.pop();
      showDialogAlert(
          context: context,
          message: "Porfavor verifique todos los campos",
          seconds: 3);
      return;
    }
    final newPrice = fixPrice(price);
    String url = "https://secure.culqi.com/v2/tokens/yape";
    Map<String, dynamic> body = {
      "otp": codeOTP,
      "number_phone": phone,
      "amount": newPrice,
      "email": email
    };
    Response<dynamic> response = await Dio().post(url,
        data: body,
        options: Options(
            headers: {"Authorization": "Bearer pk_test_CVhb8zLkUA9dmTzi"}));
    if (response.statusCode == 201) {
      navigator.pop();

      if (context.mounted) {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (_) {
              return Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                  Text('Realizando el cobro')
                ],
              ));
            });
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
