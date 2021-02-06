import 'package:flutter/material.dart';
import 'package:gita_app/config/global_strings.config.dart';
import 'package:gita_app/config/sizing.config.dart';
import 'package:gita_app/models/GitaData.dart';
import 'package:gita_app/providers/language.provider.dart';
import 'package:gita_app/providers/progress.provider.dart';
import 'package:provider/provider.dart';

class ViewProgress extends StatefulWidget {
  @override
  _ViewProgressState createState() => _ViewProgressState();
}

class _ViewProgressState extends State<ViewProgress> {
  getTotalVersesInChapter(GitaData gitaData, int chapterNumber, bool isHindi) {
    if (isHindi)
      return gitaData.getHindiNumber(int.parse(gitaData.getChapterVerseNumbers(chapterNumber.toString()).last));
    else
      return gitaData.getChapterVerseNumbers(chapterNumber.toString()).last;
  }

  getReadCountInLanguage(GitaData gitaData, int chapterNumber, List<String> readVerses, bool isHindi) {
    int readCount = 0;
    List<String> verseNumbers = gitaData.getChapterVerseNumbers(chapterNumber.toString());
    for (String index in readVerses) {
      if (verseNumbers[int.parse(index)].contains("-"))
        readCount += 2;
      else
        readCount += 1;
    }

    if (isHindi)
      return gitaData.getHindiNumber(readCount).toString();
    else
      return readCount.toString();
  }

  getProgressInLanguage(GitaData gitaData, int chapterNumber, int progress, bool ishindi) {
    final String verseNumber = gitaData.getChapterVerseNumbers(chapterNumber.toString())[progress];

    if (ishindi) {
      String verseNumberHindi = gitaData.getHindiNumber(int.parse(verseNumber.split("-")[0]));
      if (verseNumber.indexOf("-") != -1) verseNumberHindi += "-" + gitaData.getHindiNumber(int.parse(verseNumber.split("-")[1]));
      return verseNumberHindi;
    } else
      return gitaData.getChapterVerseNumbers(chapterNumber.toString())[progress];
  }

  getChapterNumberInLanguage(GitaData gitaData, int chapterNumber, bool isHindi) {
    if (isHindi)
      return gitaData.getChapterNumberInHindi(chapterNumber);
    else
      return chapterNumber;
  }

  @override
  Widget build(BuildContext context) {
    final LanguageProvider languageProvider = Provider.of<LanguageProvider>(context);
    final ProgressProvider progressProvider = Provider.of<ProgressProvider>(context);
    final GitaData gitaData = Provider.of<GitaData>(context);

    // TODO: create a ui Chapter 1  1/47 (Start Again)
    //       Last read Verse 1
    // TODO: create function to convert chapter number to hindi and verse page index to verse number

    // print(gitaData.getHindiNumber(5));

    return SimpleDialog(
        title: Text(
          GlobalStrings.data[languageProvider.currentLanguage]["progress"],
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline6,
        ),
        children: <Widget>[
          Stack(children: [
            Positioned(
              child: Container(
                width: 40 * SizeConfig.heightMultiplier,
                height: SizeConfig.isPotrait() ? 50 * SizeConfig.heightMultiplier : 30 * SizeConfig.heightMultiplier,
                child: ListView.builder(
                  itemCount: 18,
                  itemBuilder: (context, index) {
                    List<String> totalReadVerses = progressProvider.getReadCount(index + 1);
                    String lastRead = totalReadVerses.length > 0 ? getProgressInLanguage(gitaData, index + 1, progressProvider.getProgress(index + 1), languageProvider.isHindi) : "--";
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(2.5 * SizeConfig.heightMultiplier),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(GlobalStrings.data[languageProvider.currentLanguage]["chapter"] + " " + getChapterNumberInLanguage(gitaData, index + 1, languageProvider.isHindi).toString(),
                                      style: Theme.of(context).textTheme.headline4),
                                  RichText(
                                    text: TextSpan(
                                      text: GlobalStrings.data[languageProvider.currentLanguage]["totalRead"] + ": ",
                                      style: Theme.of(context).textTheme.bodyText2,
                                      children: [
                                        TextSpan(
                                          text: getReadCountInLanguage(gitaData, index + 1, totalReadVerses, languageProvider.isHindi),
                                          style: Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.red),
                                        ),
                                        TextSpan(text: "/" + getTotalVersesInChapter(gitaData, index + 1, languageProvider.isHindi).toString())
                                      ],
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text: GlobalStrings.data[languageProvider.currentLanguage]["lastRead"] + ": ",
                                      style: Theme.of(context).textTheme.bodyText2,
                                      children: [
                                        TextSpan(
                                          text: lastRead,
                                          style: Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.red),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            ButtonTheme(
                              height: 5 * SizeConfig.heightMultiplier,
                              child: RaisedButton(
                                shape: CircleBorder(),
                                onPressed: () => setState(() => progressProvider.resetChapterProgress(index + 1)),
                                color: Colors.red,
                                child: Icon(
                                  Icons.restore_rounded,
                                  color: Colors.white,
                                  size: 5 * SizeConfig.imageSizeMultiplier,
                                ),
                              ),
                            )
                          ],
                        ),
                        index < 17
                            ? Divider(
                                color: Theme.of(context).dividerColor,
                                endIndent: 5 * SizeConfig.heightMultiplier,
                                indent: 5 * SizeConfig.heightMultiplier,
                                thickness: 0.5,
                              )
                            : SizedBox.shrink(),
                        index == 17
                            ? Padding(
                                padding: EdgeInsets.symmetric(vertical: 3 * SizeConfig.heightMultiplier),
                              )
                            : SizedBox.shrink(),
                      ],
                    );
                  },
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 6 * SizeConfig.heightMultiplier),
                child: FloatingActionButton(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                  onPressed: () => setState(() => progressProvider.resetAll()),
                  child: Text(
                    GlobalStrings.data[languageProvider.currentLanguage]["clearProgress"],
                    style: Theme.of(context).textTheme.button,
                  ),
                ),
              ),
            ),
          ]),
        ]);
  }
}
