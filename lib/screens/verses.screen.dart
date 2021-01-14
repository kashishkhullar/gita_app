import 'package:flutter/material.dart';
import 'package:gita_app/config/sizing.config.dart';
import 'package:gita_app/helpers/home.clipper.dart';
import 'package:gita_app/models/GitaData.dart';
import 'package:gita_app/models/Verse.dart';
import 'package:gita_app/providers/progress.provider.dart';
import 'package:gita_app/widgets/verse.widget.dart';
import 'package:gita_app/widgets/verse_panel.widget.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class VersesScreen extends StatefulWidget {
  static final String routeName = "/verses";

  VersesScreen({Key key}) : super(key: key);

  @override
  _VersesScreenState createState() => _VersesScreenState();
}

class _VersesScreenState extends State<VersesScreen> {
  int _pageNumber = 0;

  PanelController _pc;

  @override
  void initState() {
    _pc = new PanelController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int currentChapterNumber = ModalRoute.of(context).settings.arguments;

    final gitaData = Provider.of<GitaData>(context, listen: false);
    final List<Verse> verseList = gitaData.getVerses(currentChapterNumber);

    final ProgressProvider progress = Provider.of<ProgressProvider>(context, listen: false);
    print("get ${progress.getProgress(currentChapterNumber)}");

    _pageNumber = progress.getProgress(currentChapterNumber);

    return WillPopScope(
      onWillPop: () async {
        if (_pc.isPanelClosed)
          return true;
        else {
          _pc.close();
          return false;
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Stack(
          children: [
            buildTopImage(context, currentChapterNumber),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: SizeConfig.isPotrait() ? 70 * SizeConfig.heightMultiplier : 60 * SizeConfig.heightMultiplier,
                child: PageView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: verseList.length,
                  controller: PageController(
                    viewportFraction: 0.75,
                    initialPage: progress.getProgress(currentChapterNumber),
                  ),
                  onPageChanged: (int changedPageNumber) {
                    setState(() => _pageNumber = changedPageNumber);
                    progress.setProgress(currentChapterNumber, changedPageNumber);
                  },
                  itemBuilder: (_, index) {
                    return Transform.scale(
                      scale: index == _pageNumber ? 0.95 : 0.85,
                      child: VerseCard(
                        pc: _pc,
                        verse: verseList[index],
                      ),
                    );
                  },
                ),
              ),
              // ),
            ),
            VerseBottomPanel(
              pc: _pc,
              verseList: verseList,
              pageNumber: _pageNumber,
            )
          ],
        ),
      ),
    );
  }

  Container buildTopImage(BuildContext context, int currentChapterNumber) {
    return Container(
      child: ClipPath(
        // borderRadius: BorderRadius.vertical(bottom: Radius.circular(50)),
        clipper: TopClipper(),
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
