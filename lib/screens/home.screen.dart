import 'package:flutter/material.dart';
import 'package:gita_app/config/sizing.config.dart';
import 'package:gita_app/helpers/home.clipper.dart';
import 'package:gita_app/config/global_strings.config.dart';
import 'package:gita_app/providers/theme.provider.dart';
import 'package:gita_app/screens/chapters.screen.dart';
import 'package:gita_app/widgets/app_drawer.widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = "/home";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }

  RaisedButton buildListButton(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        Navigator.of(context).pushNamed(ChaptersScreen.routeName);
      },
      color: Theme.of(context).buttonColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(90)),
      child: Container(
        padding: EdgeInsets.all(SizeConfig.heightMultiplier),
        child: Text(
          GlobalStrings.chapterList,
          style: Theme.of(context).textTheme.button,
        ),
      ),
    );
  }

  Container buildAboutBody(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.5 * SizeConfig.textMultiplier),
      child: Text(
        GlobalStrings.aboutGita,
        style: Theme.of(context).textTheme.bodyText1,
        textAlign: TextAlign.center,
      ),
    );
  }

  ClipPath buildClippedTitle(BuildContext context) {
    return ClipPath(
      clipper: TopClipper(),
      child: Container(
        height: SizeConfig.isPotrait() ? 35 * SizeConfig.heightMultiplier : 30 * SizeConfig.heightMultiplier,
        padding: EdgeInsets.only(bottom: 4 * SizeConfig.heightMultiplier),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
        ),
        child: Center(
          child: Text(
            GlobalStrings.srimadBhagwatGita,
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
      ),
    );
  }
}
