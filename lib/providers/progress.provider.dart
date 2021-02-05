import 'package:flutter/cupertino.dart';
import 'package:gita_app/providers/storage.provider.dart';

class ProgressProvider extends ChangeNotifier {
  StorageProvider _storageProvider;
  ProgressProvider(StorageProvider storageProvider) {
    _storageProvider = storageProvider;
  }
  // final Map<int, int> _progress = {
  //   1: 0,
  //   2: 0,
  //   3: 0,
  //   4: 0,
  //   5: 0,
  //   6: 0,
  //   7: 0,
  //   8: 0,
  //   9: 0,
  //   10: 0,
  //   11: 0,
  //   12: 0,
  //   13: 0,
  //   14: 0,
  //   15: 0,
  //   16: 0,
  //   17: 0,
  //   18: 0,
  // };

  int getProgress(int chapterNumber) {
    return _storageProvider.getProgress(chapterNumber);
  }

  void setProgress(int chapterNumber, int pageNumber) {
    _storageProvider.setProgress(chapterNumber, pageNumber);
  }

  int getReadCount(int chapterNumber) {
    return _storageProvider.getReadCount(chapterNumber);
  }

  void setRead(int chapterNumber, int verseNumber) {
    _storageProvider.setRead(chapterNumber, verseNumber);
  }
}
