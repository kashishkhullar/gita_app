import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:gita_app/models/Chapter.dart';
import 'package:gita_app/models/Verse.dart';

class GitaData {
  Map<String, dynamic> gitaData;

  GitaData(this.gitaData);

  Chapter getChapter(String chapterNumber) {
    Map<String, dynamic> chapterData = gitaData["chapters"];
    print("getchaptercalled");
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
    print("getchapter s called");
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
      );
      verseList.add(verse);
    }
    return verseList;
  }

  int countVersesInChapter(int chapterNumber) {
    return gitaData["chapters"]["$chapterNumber"]["verse_numbers"].length;
  }

  void reloadData(BuildContext context) async {
    var dataString = await DefaultAssetBundle.of(context).loadString("assets/data/dataset_english.json");
    gitaData = jsonDecode(dataString);
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
