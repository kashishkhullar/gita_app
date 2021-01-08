import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
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

class _ChapterDetailScreenState extends State<ChapterDetailScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _animation = Tween(begin: 0.0, end: 0.0).animate(_controller);
  }

  int _visible = 0;

  showCards() {
    if (mounted && _visible == 0) {
      Future.delayed(Duration(milliseconds: 20), () {
        setState(() {
          _visible = 1;
        });
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int currentChapterNumber = ModalRoute.of(context).settings.arguments;

    final GitaData gitaData = Provider.of<GitaData>(context);
    final Chapter chapter = gitaData == null
        ? []
        : gitaData.getChapter(currentChapterNumber.toString());

    print("build chapter details");
    showCards();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.5,
            child: Hero(
              tag: 101,
              child: Image.asset(
                "assets/images/chapters/$currentChapterNumber.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            // child: AnimatedOpacity(
            //   onEnd: () => {
            //     setState(() {
            //       _visible = 1;
            //     })
            //   },
            //   curve: Curves.ease,
            //   opacity: _visible == 0 ? 0.0 : 1.0,
            //   duration: Duration(seconds: 1),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width * 0.8,
              // color: Colors.red,
              margin: EdgeInsets.symmetric(vertical: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.white,
                boxShadow: [
                  new BoxShadow(
                    color: Colors.grey,
                    blurRadius: 20,
                    // spreadRadius: 10,
                    offset: Offset(0, 20),
                  )
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "अध्याय " + chapter.chapter_number,
                    style: TextStyle(
                        fontSize: 50,
                        color: Theme.of(context).primaryColorDark),
                  ),
                  Text(
                    chapter.name,
                    style: TextStyle(fontSize: 40),
                  ),
                  Text(chapter.name_meaning,
                      style: TextStyle(
                          fontSize: 30, color: Theme.of(context).primaryColor)),

                  // padding: EdgeInsets.symmetric(horizontal: 10),

                  Container(
                    // width: 500,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: AutoSizeText(
                      chapter.chapter_summary,
                      minFontSize: 18,
                      maxFontSize: 20,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  RaisedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(VersesScreen.routeName,
                          arguments: currentChapterNumber);
                    },
                    color: Colors.amber[600],
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "श्लोकों यों की सूची",
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(90)),
                  ),
                ],
              ),
            ),
            // ),
          )
        ],
      ),
    );
  }
}
