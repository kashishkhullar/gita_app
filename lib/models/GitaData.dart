import 'dart:convert';

import 'package:gita_app/models/Chapter.dart';

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
}
