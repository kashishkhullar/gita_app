import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gita_app/config/global_strings.config.dart';
import 'package:gita_app/config/sizing.config.dart';
import 'package:gita_app/models/Verse.dart';
import 'package:gita_app/providers/language.provider.dart';
import 'package:gita_app/widgets/audio_player.widget.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class VerseBottomPanel extends StatefulWidget {
  VerseBottomPanel({
    Key key,
    @required PanelController pc,
    @required this.verseList,
    @required int pageNumber,
    this.chapterNumber,
  })  : _pc = pc,
        _pageNumber = pageNumber,
        super(key: key);

  final PanelController _pc;
  final List<Verse> verseList;
  final int _pageNumber;
  final int chapterNumber;

  @override
  _VerseBottomPanelState createState() => _VerseBottomPanelState();
}

class _VerseBottomPanelState extends State<VerseBottomPanel> {
  ScrollController _sc;

  @override
  Widget build(BuildContext context) {
    final LanguageProvider languageProvider = Provider.of<LanguageProvider>(context);

    return SlidingUpPanel(
      collapsed: Column(
        children: [
          Icon(
            Icons.drag_handle,
            color: Theme.of(context).dividerColor,
          ),
          Text(
            GlobalStrings.data[languageProvider.currentLanguage]["panelText"],
            style: Theme.of(context).textTheme.overline,
          )
        ],
      ),
      controller: widget._pc,
      onPanelClosed: () => _sc.jumpTo(0),
      // padding: EdgeInsets.symmetric(horizontal: 10),
      panelSnapping: true,
      backdropEnabled: true,
      backdropColor: Theme.of(context).primaryColor,
      color: Theme.of(context).cardColor,
      minHeight: 6 * SizeConfig.heightMultiplier,
      maxHeight: SizeConfig.isPotrait() ? 70 * SizeConfig.heightMultiplier : 50 * SizeConfig.heightMultiplier,
      panelBuilder: (sc) {
        _sc = sc;
        return buildPanelContent(context, sc, widget.chapterNumber, widget._pageNumber);
      },
      borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50)),
    );
  }

  SingleChildScrollView buildPanelContent(BuildContext context, ScrollController sc, int chapterNumber, int pageNumber) {
    final LanguageProvider languageProvider = Provider.of<LanguageProvider>(context);

    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      controller: sc,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 3.5 * SizeConfig.heightMultiplier),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Padding(padding: EdgeInsets.symmetric(vertical: 3 * SizeConfig.heightMultiplier)),
            Container(
              padding: EdgeInsets.symmetric(horizontal: SizeConfig.heightMultiplier),
              child: Column(
                children: [
                  Text(
                    GlobalStrings.data[languageProvider.currentLanguage]["verse"],
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  Text(
                    widget.verseList[widget._pageNumber].text,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 1.5 * SizeConfig.heightMultiplier)),
            new GitaAudioPlayer(
              fileName: "${chapterNumber}_${widget.verseList[widget._pageNumber].key}.mp3",
              width: 30 * SizeConfig.heightMultiplier,
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 1.5 * SizeConfig.heightMultiplier)),
            !languageProvider.isHindi
                ? Container(
                    padding: EdgeInsets.symmetric(horizontal: SizeConfig.heightMultiplier),
                    child: Column(
                      children: [
                        FittedBox(
                          child: Text(
                            GlobalStrings.data[languageProvider.currentLanguage]["transliteration"],
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headline2,
                          ),
                        ),
                        Text(
                          widget.verseList[widget._pageNumber].transliteration,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyText2.copyWith(
                                fontSize: 2.5 * SizeConfig.textMultiplier,
                                fontStyle: FontStyle.italic,
                              ),
                        ),
                      ],
                    ),
                  )
                : SizedBox.shrink(),
            Padding(padding: EdgeInsets.symmetric(vertical: 1.5 * SizeConfig.heightMultiplier)),
            Container(
              padding: EdgeInsets.symmetric(horizontal: SizeConfig.heightMultiplier),
              child: Column(
                children: [
                  FittedBox(
                    child: Text(
                      GlobalStrings.data[languageProvider.currentLanguage]["meaning"],
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  ),
                  Text(
                    widget.verseList[widget._pageNumber].wordMeanings,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 1.5 * SizeConfig.heightMultiplier)),
            Container(
              padding: EdgeInsets.symmetric(horizontal: SizeConfig.heightMultiplier),
              child: Column(
                children: [
                  Text(
                    GlobalStrings.data[languageProvider.currentLanguage]["translation"],
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  Text(
                    widget.verseList[widget._pageNumber].meaning,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 1.5 * SizeConfig.heightMultiplier)),
          ],
        ),
      ),
    );
  }
}
