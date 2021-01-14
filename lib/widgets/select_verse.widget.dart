import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gita_app/models/GitaData.dart';
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
  String selectedVerse = "1";

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(
        "अध्याय की संख्या और उसके श्लोक की संख्या का चयन करें",
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
                  print(newValue);
                  setState(() {
                    selectedChapter = newValue;
                    selectedVerse = "1";
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
            // minWidth: 100,
            onPressed: () {
              Provider.of<ProgressProvider>(context, listen: false)
                  .setProgress(int.parse(selectedChapter), int.parse(selectedVerse) - 1);
              Navigator.of(context).pushReplacementNamed(VersesScreen.routeName, arguments: int.parse(selectedChapter));
            },
            color: Theme.of(context).buttonColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(90)),
            child: Text(
              "श्लोक पढ़ें",
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
      dropdownList.add(DropdownMenuItem<String>(
        value: i.toString(),
        child: Text(
          gitaData.getChapterNumberInHindi(i),
          style: Theme.of(context).textTheme.headline4,
        ),
      ));
    }
    return dropdownList;
  }

  List<DropdownMenuItem<String>> buildVerseSelectorList(String chapterNumber) {
    // List<DropdownMenuItem<String>> dropdownList = [];

    final GitaData gitaData = Provider.of<GitaData>(context);

    return gitaData
        .getChapterVerseNumbers(chapterNumber)
        .map((verseNumber) => DropdownMenuItem<String>(
              value: verseNumber,
              child: Text(
                gitaData.getVerseNumberInHindi(chapterNumber, verseNumber),
                style: Theme.of(context).textTheme.headline4,
              ),
            ))
        .toList();
  }
}
