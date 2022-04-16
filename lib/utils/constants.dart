library constants;

import 'package:flutter/material.dart';

class Constants {
  static const String TITLE = 'Resiklos';
  static const double PAGE_PADDING = 15.0;
  static const String SAMPLE_AVATAR = '';
}

class ResiklosMaterialColors {
  static const primary = MaterialColor(0xFF00A6BE, <int, Color>{
    50: Color.fromRGBO(0, 188, 212, .1),
    100: Color.fromRGBO(0, 188, 212, .2),
    200: Color.fromRGBO(0, 188, 212, .3),
    300: Color.fromRGBO(0, 188, 212, .4),
    400: Color.fromRGBO(0, 188, 212, .5),
    500: Color.fromRGBO(0, 188, 212, .6),
    600: Color.fromRGBO(0, 188, 212, .7),
    700: Color.fromRGBO(0, 188, 212, .8),
    800: Color.fromRGBO(0, 188, 212, .9),
    900: Color.fromRGBO(0, 188, 212, 1),
  });
}

class ResiklosColors {
  static const Color primary = Color(0xFF00A6BE); //Color(0xFF00BCD4);
  static const Color primaryDark = Color(0xFF0D90A3);
  static const Color background = Color(0xFFFAFAFA);
  static const Color shadow = Color(0x14000000);
  static const Color textColor = Color(0xFF707070);
  static const Color dark = Color(0xFF707070);
  static const Color textColorLight = Color(0xFFFFFFFF);
  static const Color muted = Color(0xffd4d4d4);
  static const Color warning = Color(0xFFFFCC5A);
  static const Color warningDark = Color(0xFFFF9D00);
  static const Color success = Color(0xFF75BE00);
  static const Color light = Color(0xfff4f4f4);
}

class ResiklosTypography {
  static const dark = Color(0xFF707070);
  static const light = Color(0xFFFFFFFF);
}
