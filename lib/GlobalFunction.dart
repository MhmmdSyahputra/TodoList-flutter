import 'package:flutter/material.dart';

Color myTheme(bool valTheme) {
  if (valTheme) {
    return Color(0xff2b2d42);
  } else {
    return Color(0xFFffffff);
  }
}

Color myThemeHead(bool valTheme) {
  if (valTheme) {
    return Color(0xff2b2d42);
  } else {
    return Color(0xcc0077b6);
  }
}

Color myThemeBottom(bool valTheme) {
  if (valTheme) {
    return Color(0xff2b2d42);
  } else {
    return Color(0xFFFFFFFF);
  }
}
