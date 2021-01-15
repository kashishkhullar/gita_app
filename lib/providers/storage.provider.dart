import 'package:shared_preferences/shared_preferences.dart';

class StorageProvider {
  static StorageProvider _storage;
  static SharedPreferences _preferences;

  static Future<StorageProvider> getStorage() async {
    if (_storage == null) {
      _storage = StorageProvider();
    }
    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }
    return _storage;
  }

  bool get isDarkTheme {
    if (!_preferences.containsKey("isDark")) {
      setTheme(isDark: false);
    }
    return _preferences.getBool("isDark");
  }

  void setTheme({bool isDark}) {
    _preferences.setBool("isDark", isDark);
  }

  void setProgress(int chapterNumber, int page) {
    _preferences.setInt("$chapterNumber", page);
  }

  int getProgress(int chapterNumber) {
    if (!_preferences.containsKey("$chapterNumber")) {
      setProgress(chapterNumber, 0);
    }
    return _preferences.getInt("$chapterNumber");
  }
}
