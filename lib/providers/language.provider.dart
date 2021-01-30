import 'package:flutter/material.dart';
import 'package:gita_app/providers/storage.provider.dart';

class LanguageProvider with ChangeNotifier {
  bool _isHindi = true;
  String currentLanguage = "hindi";

  StorageProvider _storageProvider;

  LanguageProvider(StorageProvider storageProvider) {
    if (storageProvider == null) {
      currentLanguage = "hindi";
    } else {
      _isHindi = storageProvider.isHindi;
      currentLanguage = _isHindi == true ? "hindi" : "english";
    }
    _storageProvider = storageProvider;
  }

  bool get isHindi => _isHindi;

  void setHindi() {
    _isHindi = true;
    currentLanguage = "hindi";
    _storageProvider.setLanguage(isHindi: _isHindi);
    notifyListeners();
  }

  void setEnglish() {
    _isHindi = false;
    currentLanguage = "english";
    _storageProvider.setLanguage(isHindi: _isHindi);
    notifyListeners();
  }
}
