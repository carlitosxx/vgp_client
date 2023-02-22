// import 'dart:async';

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:vgp_cliente/utils/show_dialog.dart';
import '../models/error.model.dart';
import '../models/response_get_student_by_email_and_password.model.dart';
import '/environment/environment.dart';
import 'package:dio/dio.dart';
void getStudentByEmailAndPassword({
  required BuildContext context,
  required String email,
  required String password}) async{  
  late Timer timer;
  try {        
    NavigatorState navigator = Navigator.of(context);
    
    FlutterSecureStorage secureStorage=const FlutterSecureStorage();    
    String url = "${Environment.apiUrl}auth/login";    
    Map<String, dynamic> body = {      
        "email":email,
        "password":password      
    };  
    Response<dynamic> response = await Dio().post(url,data: body);
    if (response.statusCode == 201) {      
      ResponseGetStudentByEmailAndPassword bodyResponse=responseGetStudentByEmailAndPasswordFromJson(json.encode(response.data));      
      secureStorage.write(key: 'token', value: bodyResponse.data.token);
      navigator.pop();
      if(context.mounted){
        Navigator.of(context).pushReplacementNamed("/home");
      }   
    }
  } on DioError catch (e) {
     if (e.type == DioErrorType.response) {
        switch (e.response!.statusCode) {
          case 400:
          //todo! BAD REQUEST
            Navigator.pop(context);
            final error = errorFromJson(e.response.toString());            
            String accMessageErrors='';
            for (var element in error.message) {
              accMessageErrors = '$accMessageErrors\n$element';              
            }
            showDialogAlert(
              context: context,
              message: accMessageErrors,
              seconds: 3);  
           break;
          case 401:
          //todo! UNAUTHORIZED
            Navigator.pop(context);
            final error = errorFromJson(e.response.toString()); 
            showDialogAlert(
              context: context,
              message: error.message[0],
              seconds: 3); 
            // showDialog(context: context, builder: ((context) {
            //    timer = Timer(const Duration(seconds: 3), () {
            //     Navigator.of(context).pop();
            //   });
            //   return AlertDialog(
            //     scrollable: true,
            //     content: Column(
            //       children: [Text(error.message[0])],
            //     ),
            //   );
            // })).then((value) {
            //     if (timer.isActive) timer.cancel();                
            // }); 
            break;
          case 404:
            throw Exception("Error 404");
        }
      }      
  }
}