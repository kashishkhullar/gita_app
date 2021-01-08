import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gita_app/config/global_strings.config.dart';
import 'package:gita_app/config/sizing.config.dart';
import 'package:gita_app/models/Verse.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class VerseBottomPanel extends StatefulWidget {
  VerseBottomPanel({
    Key key,
    @required PanelController pc,
    @required this.verseList,
    @required int pageNumber,
  })  : _pc = pc,
        _pageNumber = pageNumber,
        super(key: key);

  final PanelController _pc;
  final List<Verse> verseList;
  final int _pageNumber;

  @override
  _VerseBottomPanelState createState() => _VerseBottomPanelState();
}

class _VerseBottomPanelState extends State<VerseBottomPanel> {
  ScrollController _sc;

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      collapsed: Column(
        children: [
          Icon(Icons.drag_handle),
          Text(
            GlobalStrings.panelText,
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
      minHeight: 6 * SizeConfig.heightMultiplier,
      maxHeight: SizeConfig.isPotrait()
          ? 70 * SizeConfig.heightMultiplier
          : 50 * SizeConfig.heightMultiplier,
      panelBuilder: (sc) {
        _sc = sc;
        return buildPanelContent(context, sc);
      },
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50), topRight: Radius.circular(50)),
    );
  }

  SingleChildScrollView buildPanelContent(
      BuildContext context, ScrollController sc) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      controller: sc,
      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      child: Container(
        // color: Colors.red,
        margin:
            EdgeInsets.symmetric(horizontal: 3.5 * SizeConfig.heightMultiplier),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 3 * SizeConfig.heightMultiplier)),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: 1 * SizeConfig.heightMultiplier),
              child: Column(
                children: [
                  Text(
                    GlobalStrings.verse,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  Text(
                    widget.verseList[widget._pageNumber].text,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 3 * SizeConfig.heightMultiplier))
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: 1 * SizeConfig.heightMultiplier),
              child: Column(
                children: [
                  Text(
                    GlobalStrings.meaning,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  Text(
                    widget.verseList[widget._pageNumber].wordMeanings,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 3 * SizeConfig.heightMultiplier))
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: 1 * SizeConfig.heightMultiplier),
              child: Column(
                children: [
                  Text(
                    GlobalStrings.translation,
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
          ],
        ),
      ),
    );
  }
}
