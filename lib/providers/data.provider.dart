import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gita_app/models/GitaData.dart';

class DataProvider {
  final String _assetPath = "assets/data/dataset.json";

  Future<GitaData> loadGitaData(BuildContext context) async {
    var dataString = await loadAsset(context);
    Map<String, dynamic> gitaData = jsonDecode(dataString);

    return GitaData(gitaData);
  }

  Future<String> loadAsset(BuildContext context) async {
    return await DefaultAssetBundle.of(context).loadString(_assetPath);
  }
}
