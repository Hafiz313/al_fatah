import 'package:flutter/material.dart';
import 'package:inventory_app/utils/app_color.dart';



Widget simpleTxtField({
  bool ishidden = false,
  @required labelTxt,
  @required keyboardType,
  @required onsaved,
  @required validator,
}) {
  return TextFormField(

    style: TextStyle(color: Colors.white),
    obscureText: ishidden,
    keyboardType: keyboardType,
    onSaved: onsaved,
    validator: validator,
    decoration: InputDecoration(
        labelText: labelTxt,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: kAppPrimaryColor)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide:  BorderSide(color: kAppPrimaryColor)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color:kAppPrimaryColor)),
        labelStyle: TextStyle(color: kAppPrimaryColor)),
  );
}

// ignore: non_constant_identifier_names
Widget TxtFieldNonBorder({
  bool ishidden = false,
  @required keyboardType,
  @required onsaved,
  @required validator,
  Color labelTextColor
}) {
  return TextFormField(

    style: TextStyle(color: Colors.white),
    obscureText: ishidden,
    keyboardType: keyboardType,
    onSaved: onsaved,
    validator: validator,
    decoration: InputDecoration(
        border: InputBorder.none,
        labelStyle: TextStyle(color:labelTextColor ?? Colors.white)),
  );
}