import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:gita_app/models/Chapter.dart';
import 'package:gita_app/models/Verse.dart';

class GitaData with ChangeNotifier {
  Map<String, dynamic> gitaData;

  GitaData();

  Chapter getChapter(String chapterNumber) {
    Map<String, dynamic> chapterData = gitaData["chapters"];
    var chapter = Chapter(
      chapter_number: chapterData[chapterNumber]["chapter_number"],
      chapter_summary: chapterData[chapterNumber]["chapter_summary"],
      name: chapterData[chapterNumber]["name"],
      name_meaning: chapterData[chapterNumber]["name_meaning"],
      verse_numbers: chapterData[chapterNumber]["verse_numbers"],
      verses_count: chapterData[chapterNumber]["verse_count"],
    );
    return chapter;
  }

  List<Chapter> getChapters() {
    var chapterList = List<Chapter>();

    Map<String, dynamic> chapterData = gitaData["chapters"];

    for (var i = 1; i <= 18; i++) {
      var chapter = Chapter(
        chapter_number: chapterData["$i"]["chapter_number"].toString(),
        chapter_summary: chapterData["$i"]["chapter_summary"],
        name: chapterData["$i"]["name"],
        name_meaning: chapterData["$i"]["name_meaning"],
        verse_numbers: chapterData["$i"]["verse_numbers"],
        verses_count: chapterData["$i"]["verse_count"],
      );
      chapterList.add(chapter);
    }
    return chapterList;
  }

  List<Verse> getVerses(int chapterNumber) {
    var verseList = List<Verse>();

    List<dynamic> verseNumbers = gitaData["chapters"]["$chapterNumber"]["verse_numbers"];

    Map<String, dynamic> verseData = gitaData["verses"]["$chapterNumber"];

    for (var verseNumber in verseNumbers) {
      var verse = Verse(
        meaning: verseData["$verseNumber"]["meaning"],
        text: verseData["$verseNumber"]["text"],
        verseNumber: verseData["$verseNumber"]["verse_number"],
        wordMeanings: verseData["$verseNumber"]["word_meanings"],
        transliteration: verseData["$verseNumber"]["transliteration"] ?? null,
        key: verseNumber,
      );
      verseList.add(verse);
    }
    return verseList;
  }

  int countVersesInChapter(int chapterNumber) {
    return gitaData["chapters"]["$chapterNumber"]["verse_numbers"].length;
  }

  void loadData(BuildContext context, bool isHindi) async {
    String filePath;
    if (isHindi)
      filePath = "dataset_hindi.json";
    else
      filePath = "dataset_english.json";
    var dataString = await DefaultAssetBundle.of(context).loadString("assets/data/$filePath");
    gitaData = jsonDecode(dataString);
    notifyListeners();
  }

  String getChapterNumberInHindi(int chapterNumber) {
    return gitaData["chapters"]["$chapterNumber"]["chapter_number"];
  }

  List<String> getChapterVerseNumbers(String chapterNumber) {
    return gitaData["chapters"]["$chapterNumber"]["verse_numbers"].map<String>((i) => i.toString()).toList();
  }

  String getVerseNumberInHindi(String chapterNumber, String verseNumber) {
    return gitaData["verses"]["$chapterNumber"]["$verseNumber"]["verse_number"];
  }
}
