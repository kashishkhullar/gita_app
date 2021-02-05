import 'dart:io';

import 'package:audioplayers/audio_cache.dart';

class GitaAudioCache {
  GitaAudioCache._();

  static AudioCache _audioCache;

  static init() {
    if (_audioCache == null) {
      _audioCache = AudioCache(prefix: "assets/audios/");
    }
  }

  static getInstance() {
    if (_audioCache == null) {
      _audioCache = AudioCache(prefix: "assets/audios/");
      return _audioCache;
    } else
      return _audioCache;
  }

  static clearCache() {
    _audioCache.clearCache();
  }

  static Future<File> loadFile(String fileName) {
    if (_audioCache == null) _audioCache = AudioCache(prefix: "assets/audios/");
    return _audioCache.load(fileName);
  }
}
