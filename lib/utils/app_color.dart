import 'package:flutter/material.dart';



//final Color kAppPrimaryColor = HexColor("#f89a20");
//final Color kRedColor = HexColor("#e32606)");

//final Color kWhiteColor = HexColor("#ffffff");
final Color kWhiteColor = Color(0xFFffffff);
//final Color kPrimaryTextColor = HexColor("#636363");
final Color kPrimaryTextColor = Color(0xFF636363);
final Color kAppPrimaryColor = Color(0xFFf89a20);
final Color kRedColor = Color(0xFFe32606);


//Color(0xFFe06287)


class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
  static int _getColorFromHex(String hexColor) {
    String _hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (_hexColor.length == 6) {
      _hexColor = "FF$_hexColor";
    }
    return int.parse(_hexColor, radix: 16);
  }
}