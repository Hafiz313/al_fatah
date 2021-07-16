
import 'package:flutter/material.dart';
import 'package:inventory_app/utils/app_color.dart';

class MyTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focus;
  final bool isPassword, isEmail, autoFocus,isPhone;
  final String hintText, text;
  final String Function(String) validator;
  final IconButton icon;
  MyTextFormField({
    this.controller,
    this.focus,
    this.isEmail,
    this.autoFocus,
    this.isPassword,
    this.text,
    this.hintText,
    this.validator,
    this.icon, this.isPhone,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onEditingComplete: () => FocusScope.of(context).nextFocus(),
      autofocus: autoFocus,
      cursorColor:kPrimaryTextColor,
      controller: controller,
      focusNode: focus,
      obscureText: isPassword,
      validator: validator,
      obscuringCharacter: '*',
      keyboardType: isEmail ? TextInputType.emailAddress :isPhone?TextInputType.phone: TextInputType.text,

      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: kPrimaryTextColor,
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 15,horizontal: 20),
        suffixIcon: icon,
        focusedBorder: _outlineInputBorder(Colors.blue),
        enabledBorder: _outlineInputBorder(kAppPrimaryColor),
        border: _outlineInputBorder(kAppPrimaryColor),
        errorBorder: _outlineInputBorder(kRedColor),
        focusedErrorBorder: _outlineInputBorder(kRedColor),
        hintText: hintText,
        errorMaxLines: 1,
        hintStyle: TextStyle(color: kPrimaryTextColor),
      ),
    );
  }

  OutlineInputBorder _outlineInputBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(width: 1.5, color: color?? kPrimaryTextColor),
    );
  }
}
