import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gita_app/config/global_strings.config.dart';
import 'package:gita_app/config/sizing.config.dart';
import 'package:gita_app/models/GitaData.dart';
import 'package:gita_app/providers/language.provider.dart';
import 'package:gita_app/providers/progress.provider.dart';
import 'package:gita_app/screens/verses.screen.dart';
import 'package:provider/provider.dart';

class SelectVerseDialog extends StatefulWidget {
  const SelectVerseDialog({Key key}) : super(key: key);

  @override
  _SelectVerseDialogState createState() => _SelectVerseDialogState();
}

class _SelectVerseDialogState extends State<SelectVerseDialog> {
  String selectedChapter = "1";
  String selectedVerse = "0";

  @override
  Widget build(BuildContext context) {
    LanguageProvider languageProvider = Provider.of<LanguageProvider>(context);

    return SimpleDialog(
      title: Text(
        GlobalStrings.data[languageProvider.currentLanguage]["selectVerse"],
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline6,
      ),

      // content: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              child: DropdownButton<String>(
                value: selectedChapter,
                icon: Icon(
                  Icons.arrow_drop_down_sharp,
                  color: Theme.of(context).buttonColor,
                ),
                iconSize: 30,
                elevation: 16,
                style: TextStyle(color: Theme.of(context).primaryColor),
                underline: Container(
                  height: 1,
                  color: Theme.of(context).buttonColor,
                ),
                onChanged: (String newValue) {
                  setState(() {
                    selectedChapter = newValue;
                    selectedVerse = "0";
                  });
                },
                items: buildChapterSelectorList(),
              ),
            ),
            Container(
              child: DropdownButton<String>(
                value: selectedVerse,
                icon: Icon(
                  Icons.arrow_drop_down_sharp,
                  color: Theme.of(context).buttonColor,
                ),
                iconSize: 30,
                elevation: 16,
                style: TextStyle(color: Theme.of(context).primaryColor),
                underline: Container(
                  height: 1,
                  color: Theme.of(context).buttonColor,
                ),
                onChanged: (String newValue) {
                  setState(() {
                    selectedVerse = newValue;
                  });
                },
                items: buildVerseSelectorList(selectedChapter),
              ),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 100),
          child: RaisedButton(
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.heightMultiplier),
            onPressed: () {
              Provider.of<ProgressProvider>(context, listen: false).setProgress(int.parse(selectedChapter), int.parse(selectedVerse));
              Navigator.of(context).pushNamed(VersesScreen.routeName, arguments: int.parse(selectedChapter));
            },
            color: Theme.of(context).buttonColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(90)),
            child: Text(
              GlobalStrings.data[languageProvider.currentLanguage]["readVerse"],
              style: Theme.of(context).textTheme.button,
            ),
          ),
        ),
      ],
      // )
    );
  }

  List<DropdownMenuItem<String>> buildChapterSelectorList() {
    List<DropdownMenuItem<String>> dropdownList = [];

    final GitaData gitaData = Provider.of<GitaData>(context);

    for (var i = 1; i <= 18; i++) {
      dropdownList.add(
        DropdownMenuItem<String>(
          value: i.toString(),
          child: Text(
            gitaData.getChapterNumberInHindi(i),
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
      );
    }
    return dropdownList;
  }

  List<DropdownMenuItem<String>> buildVerseSelectorList(String chapterNumber) {
    List<DropdownMenuItem<String>> dropdownList = [];

    final GitaData gitaData = Provider.of<GitaData>(context);

    final List<String> chapterVerseNumbers = gitaData.getChapterVerseNumbers(chapterNumber);

    for (int i = 0; i < chapterVerseNumbers.length; i++) {
      dropdownList.add(
        DropdownMenuItem<String>(
          value: i.toString(),
          child: Text(
            gitaData.getVerseNumberInHindi(chapterNumber, chapterVerseNumbers[i]),
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
      );
    }

    return dropdownList;
  }
}
