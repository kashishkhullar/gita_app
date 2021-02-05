import 'package:flutter/material.dart';
import 'package:gita_app/config/sizing.config.dart';
import 'package:gita_app/helpers/home_clipper.helper.dart';
import 'package:gita_app/config/global_strings.config.dart';
import 'package:gita_app/models/GitaData.dart';
import 'package:gita_app/providers/language.provider.dart';
import 'package:gita_app/screens/chapters.screen.dart';
import 'package:gita_app/widgets/app_drawer.widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = "/home";
  @override
  Widget build(BuildContext context) {
    return Consumer<GitaData>(
      builder: (context, _, child) => Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          iconTheme: Theme.of(context).iconTheme,
        ),
        drawer: AppDrawer(),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            buildClippedTitle(context),
            buildAboutBody(context),
            buildListButton(context),
            SizedBox(),
          ],
        ),
      ),
    );
  }

  RaisedButton buildListButton(BuildContext context) {
    LanguageProvider languageProvider = Provider.of<LanguageProvider>(context);

    return RaisedButton(
      onPressed: () {
        Navigator.of(context).pushNamed(ChaptersScreen.routeName);
      },
      color: Theme.of(context).buttonColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(90)),
      child: Container(
        padding: EdgeInsets.all(SizeConfig.heightMultiplier),
        child: Text(
          GlobalStrings.data[languageProvider.currentLanguage]["chapterList"],
          style: Theme.of(context).textTheme.button,
        ),
      ),
    );
  }

  Container buildAboutBody(BuildContext context) {
    LanguageProvider languageProvider = Provider.of<LanguageProvider>(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.5 * SizeConfig.textMultiplier),
      child: Text(
        GlobalStrings.data[languageProvider.currentLanguage]["aboutGita"],
        style: Theme.of(context).textTheme.bodyText1,
        textAlign: TextAlign.center,
      ),
    );
  }

  ClipPath buildClippedTitle(BuildContext context) {
    LanguageProvider languageProvider = Provider.of<LanguageProvider>(context);

    return ClipPath(
      clipper: TopClipper(),
      child: Container(
        height: SizeConfig.isPotrait() ? 40 * SizeConfig.heightMultiplier : 30 * SizeConfig.heightMultiplier,
        padding: EdgeInsets.only(bottom: 4 * SizeConfig.heightMultiplier),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
        ),
        child: Center(
          child: Text(
            GlobalStrings.data[languageProvider.currentLanguage]["shrimadBhagwatGita"],
            style: Theme.of(context).textTheme.headline1,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
