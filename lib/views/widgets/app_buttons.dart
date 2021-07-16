import 'package:flutter/material.dart';
import 'package:inventory_app/utils/app_color.dart';
import 'package:inventory_app/utils/app_sizes.dart';



Widget rectangleBtn({
  @required String txt,
  @required GestureTapCallback onPressed,
  Color bgColor,
  double fontSizeValue
  // bool progressBar
}) {
  return FlatButton(
      color: bgColor ?? kAppPrimaryColor,
      textColor: Colors.white,
      disabledColor: bgColor?? Colors.grey,
      disabledTextColor: Colors.white,
      padding: EdgeInsets.symmetric(vertical: AppSizes.appVerticalLg * 0.2,horizontal: AppSizes.appHorizontalLg * 0.6),
      onPressed:/*progressBar? null:*/onPressed,
      child:/*progressBar? SpinKitWave(color: Colors.white,size: AppSizes.appVerticalLg *0.55,):*/ Text(txt, style: TextStyle(color: kAppPrimaryColor,fontSize:fontSizeValue ?? 22,fontFamily: "Poppins" ),)
  );
}
Widget roundRectangleBtn({
  @required String txt,
  @required GestureTapCallback onPressed,
  Color textColor,
  Color bgColor,
  bool isPadding = true,
  double fontSize,

}) {
  return FlatButton(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.appHorizontalLg * 0.7),

    ),
    color:  bgColor ?? kAppPrimaryColor,
    textColor: textColor ?? Colors.white,
    disabledColor:bgColor ?? Colors.grey ,
    disabledTextColor:textColor ?? Colors.white,
    padding: isPadding ? EdgeInsets.all(AppSizes.appVerticalLg * 0.3):null,
    onPressed:onPressed,
    child: Text(
      txt,

      style: TextStyle(fontSize: 15 ?? fontSize,fontFamily: "Poppins" ),
    ),
  );
}
Widget roundTransparentBtn({
  @required String txt,
  @required GestureTapCallback onPressed,
  Color textColor,
  Color bgColor,
  Color borderColor,
  double fontSize,

}) {
  return FlatButton(
    shape: RoundedRectangleBorder(
      side:BorderSide(
          color: borderColor ?? kAppPrimaryColor,
          width: 1,
          style: BorderStyle.solid
      ) ,
      borderRadius: BorderRadius.circular(AppSizes.appHorizontalLg * 0.7,

      ),



    ),
    color:  bgColor ?? Color(0x00000000),
    textColor: textColor ?? Colors.white,
    disabledColor:bgColor ?? Colors.grey ,
    disabledTextColor:textColor ?? Colors.white,
    padding: EdgeInsets.all(AppSizes.appVerticalLg * 0.3),
    onPressed:onPressed,
    child: Text(
      txt,
      style: TextStyle(fontSize: 15 ?? fontSize,fontFamily: "Poppins" ),
    ),
  );
}