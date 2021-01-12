import 'package:flutter/cupertino.dart';
import 'package:gita_app/config/styling.config.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDark;

  ThemeProvider() {
    _isDark = false;
  }

  get isDark => _isDark;

  void setDarkTheme() {
    _isDark = true;
    notifyListeners();
  }

  void setLightTheme() {
    _isDark = false;
    notifyListeners();
  }
}
