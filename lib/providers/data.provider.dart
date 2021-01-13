import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gita_app/models/GitaData.dart';

class DataProvider {
  final String _assetDir = "assets/data/";
  String _assetPath;

  String language = "hindi";

  Future<GitaData> loadGitaData(BuildContext context) async {
    var dataString = await loadAsset(context);
    Map<String, dynamic> gitaData = jsonDecode(dataString);

    return GitaData(gitaData);
  }

  Future<String> loadAsset(BuildContext context) async {
    _assetPath = _assetDir + "dataset_$language.json";
    return await DefaultAssetBundle.of(context).loadString(_assetPath);
  }

  void setEnglish() => language = "english";

  void setHindi() => language = "hindi";
}
