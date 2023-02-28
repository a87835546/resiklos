import 'package:flutter/material.dart';

const MaterialColor white = const MaterialColor(
  0xFFFFFFFF,
  <int, Color>{
    50: Color(0xFFFFFFFF),
    100: Color(0xFFFFFFFF),
    200: Color(0xFFFFFFFF),
    300: Color(0xFFFFFFFF),
    400: Color(0xFFFFFFFF),
    500: Color(0xFFFFFFFF),
    600: Color(0xFFFFFFFF),
    700: Color(0xFFFFFFFF),
    800: Color(0xFFFFFFFF),
    900: Color(0xFFFFFFFF),
  },
);

///主色调
const MaterialColor primary = const MaterialColor(
  0xfffb7299,
  const <int, Color>{50: const Color(0xffff9db5)},
);

///主色调
const MaterialColor primary2 = const MaterialColor(
  0xFF000000,
  const <int, Color>{50: const Color(0xFFE8D7A6)},
);

class ColorUtil {
  static Color hexColor(String color) {
    int c = int.parse(color);
    int r = (c & 0xff0000) >> 16;
    int g = (c & 0xff00) >> 8;
    int b = (c & 0xff);
    return Color.fromARGB(255, r, g, b);
  }

  static Color mainTitleColor() {
    return ColorUtil.hexColor('0xC1C2C4');
  }

  static Color mainColor() {
    return ColorUtil.hexColor('0x0CC9BE');
  }
}

Color mainTitleColor() {
  return ColorUtil.hexColor('0xffC1C2C4');
}

Color color_BFBFBF() {
  return ColorUtil.hexColor('0xffbfbfbf');
}

Color color_707070() {
  return ColorUtil.hexColor('0xff707070');
}

Color color_FAFAFA() {
  return ColorUtil.hexColor('0xffFAFAFA');
}

Color color_d4d4d4() {
  return ColorUtil.hexColor('0xffD4D4D4');
}

Color mainColor() {
  return ColorUtil.hexColor('0xff00A6BE');
}
