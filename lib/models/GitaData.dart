class GitaData {
  final Map<String, dynamic> gitaData;

  GitaData(this.gitaData);

  String getChapter(String chapterNumber) {
    print(gitaData["chapters"][chapterNumber]);
    return gitaData["chapters"][chapterNumber]["chapter_summary"];
  }
}
