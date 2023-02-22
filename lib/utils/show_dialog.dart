import 'dart:async';
import 'package:flutter/material.dart';     
showDialogAlert({required BuildContext context,required String message,required int seconds}){
  late Timer timer;
  showDialog(context: context, builder: ((context){    
      timer= Timer(Duration(seconds:seconds),(){
        Navigator.of(context).pop();
      });
      return AlertDialog(
        scrollable: true,                
        content: Column(
        children: [Text(message.trim())],
        ),             
      );
  })).then((value) {
                if (timer.isActive) timer.cancel();                
  }); 
}