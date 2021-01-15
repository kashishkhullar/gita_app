import 'package:flutter/cupertino.dart';
import 'package:gita_app/providers/storage.provider.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDark;

  StorageProvider _storageProvider;

  ThemeProvider(StorageProvider storageProvider) {
    _isDark = storageProvider == null ? false : storageProvider.isDarkTheme;
    _storageProvider = storageProvider;
  }

  get isDark => _isDark;

  void setDarkTheme() {
    _isDark = true;
    _storageProvider.setTheme(isDark: true);
    notifyListeners();
  }

  void setLightTheme() {
    _isDark = false;
    _storageProvider.setTheme(isDark: false);
    notifyListeners();
  }
}
