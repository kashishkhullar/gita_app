import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gita_app/config/global_strings.config.dart';
import 'package:gita_app/config/sizing.config.dart';
import 'package:gita_app/models/Chapter.dart';
import 'package:gita_app/models/GitaData.dart';
import 'package:gita_app/providers/language.provider.dart';
import 'package:gita_app/screens/chapter_detail.screen.dart';
import 'package:provider/provider.dart';

// change text size based on language

class ChaptersScreen extends StatelessWidget {
  static final String routeName = "/chapters";

  @override
  Widget build(BuildContext context) {
    final LanguageProvider languageProvider = Provider.of<LanguageProvider>(context);

    final gitaData = Provider.of<GitaData>(context);
    final List<Chapter> chapterList = gitaData == null ? [] : gitaData.getChapters();

    final loader = SpinKitChasingDots(color: Theme.of(context).accentColor);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: chapterList.isEmpty
          ? loader
          : SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: <Widget>[
                  buildTitle(context, languageProvider),
                  buildChapterList(chapterList),
                ],
              ),
            ),
    );
  }

  ListView buildChapterList(List<Chapter> chapterList) {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: chapterList.length,
      itemBuilder: (context, index) => Container(
        margin: EdgeInsets.all(4 * SizeConfig.heightMultiplier),
        decoration: new BoxDecoration(
          boxShadow: [
            new BoxShadow(
              color: Theme.of(context).shadowColor,
              blurRadius: 20,
              spreadRadius: -10,
              offset: Offset(0, 20),
            )
          ],
        ),
        child: buildChapterCard(context, index, chapterList),
      ),
    );
  }

  Card buildChapterCard(BuildContext context, int index, List<Chapter> chapterList) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      elevation: 4,
      color: Theme.of(context).cardColor,
      margin: EdgeInsets.all(SizeConfig.heightMultiplier),
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        splashColor: Theme.of(context).primaryColorDark,
        focusColor: Theme.of(context).focusColor,
        onTap: () => Navigator.of(context).pushNamed(ChapterDetailScreen.routeName, arguments: index + 1),
        child: Column(
          children: [
            buildChapterCardTop(index),
            buildChapterCardBottom(chapterList, index, context),
          ],
        ),
      ),
    );
  }

  Container buildChapterCardBottom(List<Chapter> chapterList, int index, BuildContext context) {
    final LanguageProvider languageProvider = Provider.of<LanguageProvider>(context);

    return Container(
      height: SizeConfig.isPotrait() ? 22 * SizeConfig.heightMultiplier : 25 * SizeConfig.heightMultiplier,
      padding: EdgeInsets.all(2 * SizeConfig.heightMultiplier),
      child: Column(
        children: [
          Text(
            "${GlobalStrings.data[languageProvider.currentLanguage]["chapter"]} ${chapterList[index].chapter_number}",
            style: Theme.of(context).textTheme.headline3,
            textAlign: TextAlign.center,
          ),
          Text(
            chapterList[index].name,
            style: Theme.of(context).textTheme.headline4,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Container buildChapterCardTop(int index) {
    return Container(
      height: SizeConfig.isPotrait() ? 22 * SizeConfig.heightMultiplier : 25 * SizeConfig.heightMultiplier,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        child: Hero(
          tag: index + 1,
          child: Image.asset(
            "assets/images/chapters/${index + 1}.jpg",
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }

  Container buildTitle(BuildContext context, LanguageProvider languageProvider) {
    return Container(
      margin: EdgeInsets.only(top: 14 * SizeConfig.heightMultiplier),
      child: Text(
        GlobalStrings.data[languageProvider.currentLanguage]["chapterList"],
        style: Theme.of(context).textTheme.headline2,
        textAlign: TextAlign.center,
      ),
    );
  }
}
