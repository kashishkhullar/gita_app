import 'dart:convert';

import 'package:gita_app/models/Chapter.dart';
import 'package:gita_app/models/Verse.dart';

class GitaData {
  final Map<String, dynamic> gitaData;

  GitaData(this.gitaData);

  String getChapter(String chapterNumber) {
    print(gitaData["chapters"][chapterNumber]);
    return gitaData["chapters"][chapterNumber]["chapter_summary"];
  }

  List<Chapter> getChapters() {
    var chapterList = List<Chapter>();

    Map<String, dynamic> chapterData = gitaData["chapters"];

    for (var i = 1; i <= 18; i++) {
      var chapter = Chapter(
        chapter_number: chapterData["$i"]["chapter_number"],
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

    List<dynamic> verseNumbers =
        gitaData["chapters"]["$chapterNumber"]["verse_numbers"];

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
}
