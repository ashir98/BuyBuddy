import 'package:buy_buddy/constants/app_colors.dart';
import 'package:flutter/material.dart';

ThemeData themeData = ThemeData(
 useMaterial3: true,
 primaryColor: AppColor.primaryColor,
 elevatedButtonTheme: ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    backgroundColor: AppColor.primaryColor
  )
 ),


 inputDecorationTheme: InputDecorationTheme(
  border: outlineInputBorder,
  enabledBorder: outlineInputBorder,
  focusedBorder: outlineInputBorder,
  errorBorder: outlineInputBorder,
  disabledBorder: outlineInputBorder,

  labelStyle: const TextStyle(color: Colors.black)
  
 )

);


OutlineInputBorder outlineInputBorder = OutlineInputBorder(
  borderSide: BorderSide(color: Colors.grey),
  borderRadius: BorderRadius.circular(50),
  
  
   
);