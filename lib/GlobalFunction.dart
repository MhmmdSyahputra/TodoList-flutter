import 'package:flutter/material.dart';

Color MyTheme(bool valTheme) {
  if (valTheme) {
    return Color(0xff2b2d42);
  } else {
    return Color(0xccffffff);
  }
}

Color MyThemeHead(bool valTheme) {
  if (valTheme) {
    return Color(0xff2b2d42);
  } else {
    return Color(0xcc0077b6);
  }
}

Color MyThemeBottom(bool valTheme) {
  if (valTheme) {
    return Color(0xff2b2d42);
  } else {
    return Color(0xccFFFFFF);
  }
}
