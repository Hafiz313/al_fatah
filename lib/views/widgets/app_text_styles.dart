import 'package:flutter/material.dart';



final double textSize = 32;


TextStyle textTitle({FontWeight fontWeight, Color color, double fontSize,bool underLine=true}) =>
    TextStyle(
        fontFamily: 'Poppins',
        decoration: underLine ?TextDecoration.underline: null,
        fontSize: fontSize ?? textSize,
        color: color ?? Colors.black,
        fontWeight: fontWeight ?? FontWeight.w800);

TextStyle simpleText({FontWeight fontWeight, Color color, double fontSize}) =>
    TextStyle(
        fontFamily: 'Poppins',
        fontSize:  fontSize ?? 13,
        color: color ?? Colors.white,
        fontWeight: fontWeight ?? FontWeight.w500);
TextStyle boldText({FontWeight fontWeight, Color color, double fontSize}) =>
    TextStyle(
        fontFamily: 'Poppins',
        fontSize: fontSize ?? 20.0 ,
        color: color ?? Colors.white,
        fontWeight: fontWeight ?? FontWeight.w900
    );
