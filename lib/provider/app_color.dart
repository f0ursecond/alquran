import 'package:flutter/material.dart';

class appColor with ChangeNotifier {
  bool _isThemeDark = false;

  bool get isThemeDark => _isThemeDark;

  get bgcolor => null;
  set isThemeDark(bool value) {
    _isThemeDark = value;
    notifyListeners();
  }

  Color get color => (_isThemeDark) ? Colors.black : Colors.white;
}

class tColor with ChangeNotifier {
  bool _isTextDark = false;

  bool get isTextDark => _isTextDark;

  get bgcolor => null;
  set isTextDark(bool value) {
    _isTextDark = value;
    notifyListeners();
  }

  Color get warna => (_isTextDark) ? Colors.white : Colors.black;
}
