import 'package:flutter/material.dart';

Widget inputWidget ({
  required String hintText,
  required TextInputType textInputType,
  required int maxLength,
  required TextEditingController controller,
  required double marginHorizontal,
  }){
  return Container(
    padding:const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
    margin:  EdgeInsets.fromLTRB(marginHorizontal, 15, marginHorizontal, 0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.white.withOpacity(.2),
    ),

    child: TextField(
      // onChanged: (String value) {                              
      //   // validationService.changePhone(value);
      // },
      controller: controller,
      maxLength: maxLength,
      keyboardType: textInputType,
      textAlign: TextAlign.center,
      style: const TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold),
      decoration: InputDecoration(
          counterText: '',
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: TextStyle(
              color: Colors.white.withOpacity(0.4),
              fontWeight: FontWeight.bold
          )
      ),
    ),
  );
}