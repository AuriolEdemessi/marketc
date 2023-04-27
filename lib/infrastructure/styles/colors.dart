import 'package:flutter/material.dart';

class AppColors {

  static const Color primary1 = Color(0xFF6221bf);
  static const Color primary2 = Color(0xFF34226e);

  static const Color primary3 = Color(0xFF7668fe);

  static const Color primary = Color(0xFF1E1F3E);
  static const Color background = Color(0xFFeff6ff);
  //static const Color background = Color(0xFFF2F3F8);
  static const Color backgroundButton = Color(0xFF007bff);
  static const Color hover = Color(0xFF46bdf4);

  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color grey = Color(0xFF919191);
  static const Color error = Color(0xFFF44336);

  static const Color nearlyDarkBlue = Color(0xFF2633C5);
  static const Color notWhite = Color(0xFFEDF0F2);
  static const Color darkText = Color(0xFF253840);
  static const Color nearlyBlack = Color(0xFF213333);
  static const Color yellow = Color(0xFFffe969);
  static const Color lightGreen = Color(0xFF64DD17);


  //notif
  static const Color boxShadow3 = Color(0xFF7551FF);
  static const Color grey1 = Color(0xFFF5F5F5);
  static const text1 = Color(0xFF150A33);
  static const text2 = Color(0xFF150B3D);

}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    return int.parse(hexColor, radix: 16);
  }
}