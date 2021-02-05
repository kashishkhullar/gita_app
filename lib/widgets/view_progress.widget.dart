import 'package:flutter/material.dart';
import 'package:gita_app/config/global_strings.config.dart';
import 'package:gita_app/config/sizing.config.dart';
import 'package:gita_app/models/GitaData.dart';
import 'package:gita_app/providers/language.provider.dart';
import 'package:gita_app/providers/progress.provider.dart';
import 'package:provider/provider.dart';

class ViewProgress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LanguageProvider languageProvider = Provider.of<LanguageProvider>(context);
    final ProgressProvider progressProvider = Provider.of<ProgressProvider>(context);

    // TODO: create a ui Chapter 1  1/47 (Start Again)
    //       Last read Verse 1
    // TODO: create function to convert chapter number to hindi and verse page index to verse number

    return SimpleDialog(
        title: Text(
          GlobalStrings.data[languageProvider.currentLanguage]["progress"],
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline6,
        ),
        children: getList());
  }

  List<ProgressText> getList() {
    List<ProgressText> list = [];
    for (var i = 1; i <= 18; i++) {
      list.add(ProgressText(i));
    }
    return list;
  }
}

class ProgressText extends StatelessWidget {
  final chapterNumber;
  ProgressText(this.chapterNumber);

  @override
  Widget build(BuildContext context) {
    final ProgressProvider progressProvider = Provider.of<ProgressProvider>(context);

    return Text(progressProvider.getReadCount(chapterNumber).toString() + " " + progressProvider.getProgress(chapterNumber).toString());
  }
}
