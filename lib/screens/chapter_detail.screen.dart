import 'package:flutter/material.dart';
import 'package:gita_app/config/global_strings.config.dart';
import 'package:gita_app/config/sizing.config.dart';
import 'package:gita_app/helpers/home.clipper.dart';
import 'package:gita_app/models/Chapter.dart';
import 'package:gita_app/models/GitaData.dart';
import 'package:gita_app/screens/verses.screen.dart';
import 'package:provider/provider.dart';

class ChapterDetailScreen extends StatefulWidget {
  static final String routeName = "/chapterDetails";

  ChapterDetailScreen({Key key}) : super(key: key);

  @override
  _ChapterDetailScreenState createState() => _ChapterDetailScreenState();
}

class _ChapterDetailScreenState extends State<ChapterDetailScreen> {
  @override
  Widget build(BuildContext context) {
    int currentChapterNumber = ModalRoute.of(context).settings.arguments;

    final GitaData gitaData = Provider.of<GitaData>(context);
    final Chapter chapter =
        gitaData.getChapter(currentChapterNumber.toString());

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: <Widget>[
          buildTopImage(context, currentChapterNumber),
          buildBottomCard(context, chapter, currentChapterNumber)
        ],
      ),
    );
  }

  Align buildBottomCard(
      BuildContext context, Chapter chapter, int currentChapterNumber) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.85,
        decoration: new BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor,
              blurRadius: 20,
              spreadRadius: -10,
              offset: Offset(0, 20),
            )
          ],
        ),
        child: SingleChildScrollView(
          child: Card(
            margin: EdgeInsets.only(bottom: 2 * SizeConfig.heightMultiplier),
            elevation: 4,
            color: Theme.of(context).cardColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: SizeConfig.heightMultiplier),
                ),
                Text(
                  "${GlobalStrings.chapter} ${chapter.chapter_number}",
                  style: Theme.of(context).textTheme.headline4,
                ),
                Padding(
                  padding: EdgeInsets.only(top: SizeConfig.heightMultiplier),
                ),
                Text(
                  chapter.name,
                  style: Theme.of(context).textTheme.headline5,
                ),
                Padding(
                  padding: EdgeInsets.only(top: SizeConfig.heightMultiplier),
                ),
                Text(chapter.name_meaning,
                    style: Theme.of(context).textTheme.headline6),
                Padding(
                  padding: EdgeInsets.only(top: SizeConfig.heightMultiplier),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: SizeConfig.heightMultiplier),
                  child: Text(
                    chapter.chapter_summary,
                    style: Theme.of(context).textTheme.bodyText2,
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: SizeConfig.heightMultiplier),
                ),
                RaisedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(VersesScreen.routeName,
                        arguments: currentChapterNumber);
                  },
                  color: Theme.of(context).buttonColor,
                  child: Container(
                    padding: EdgeInsets.all(SizeConfig.heightMultiplier),
                    child: Text(
                      GlobalStrings.verseList,
                      style: Theme.of(context).textTheme.button,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(90)),
                ),
                Padding(
                  padding: EdgeInsets.only(top: SizeConfig.heightMultiplier),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container buildTopImage(BuildContext context, int currentChapterNumber) {
    return Container(
      child: ClipPath(
        clipper: TopClipper(),
        // borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.7,
          child: Image.asset(
            "assets/images/chapters/$currentChapterNumber.jpg",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
