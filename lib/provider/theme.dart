import 'package:flutter/material.dart';

class ThemeInfo with ChangeNotifier {
  String _themeColor;

  String get themeColor => _themeColor;

  setTheme(String themeColor) {
    _themeColor = themeColor;
    notifyListeners();
  }
}
