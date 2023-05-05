import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  var light =
      ThemeData(brightness: Brightness.light, primarySwatch: Colors.purple);

  var dark =
      ThemeData(brightness: Brightness.dark, primarySwatch: Colors.purple);

  bool _enableDarkMode = false;

  bool get enableDarkMode => _enableDarkMode;

  void SetBrightness(val) {
    _enableDarkMode = val;
    notifyListeners();
  }
}
