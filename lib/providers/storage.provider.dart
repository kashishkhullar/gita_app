import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

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

  bool get isHindi {
    if (!_preferences.containsKey("isHindi")) {
      setLanguage(isHindi: true);
    }
    return _preferences.getBool("isHindi");
  }

  void setLanguage({bool isHindi}) {
    _preferences.setBool("isHindi", isHindi);
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

  void resetProgress() {
    for (var i = 1; i <= 18; i++) {
      _preferences.setInt("$i", 0);
    }
  }

  void resetChapterProgress(int chapterNumber) {
    _preferences.setInt("$chapterNumber", 0);
  }

  List<String> getReadCount(int chapterNumber) {
    if (!_preferences.containsKey("read_$chapterNumber")) {
      _preferences.setStringList("read_$chapterNumber", []);
    }
    return _preferences.getStringList("read_$chapterNumber");
  }

  void setRead(int chapterNumber, int verseNumber) {
    if (!_preferences.containsKey("read_$chapterNumber")) {
      _preferences.setStringList("read_$chapterNumber", []);
    } else {
      final List<String> currentRead = _preferences.getStringList("read_$chapterNumber");
      if (currentRead.indexOf(verseNumber.toString()) == -1) {
        currentRead.add(verseNumber.toString());
        _preferences.setStringList("read_$chapterNumber", currentRead);
      }
    }
  }

  void resetReadCount() {
    for (var i = 1; i <= 18; i++) {
      _preferences.setStringList("read_$i", []);
    }
  }

  void resetChapterReadCount(int chapterNumber) {
    _preferences.setStringList("read_$chapterNumber", []);
  }
}
