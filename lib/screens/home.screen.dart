import 'package:flutter/material.dart';
import 'package:gita_app/config/sizing.config.dart';
import 'package:gita_app/helpers/home.clipper.dart';
import 'package:gita_app/config/global_strings.config.dart';
import 'package:gita_app/providers/theme.provider.dart';
import 'package:gita_app/screens/chapters.screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        iconTheme: Theme.of(context).iconTheme,
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: Container(
          color: Theme.of(context).cardColor,
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                margin: EdgeInsets.zero,
                padding: EdgeInsets.zero,
                child: Image.asset(
                  "assets/images/krishna.jpg",
                  fit: BoxFit.cover,
                ),
              ),
              ListTile(
                title: Text(
                  'जय श्री कृष्णा',
                  textAlign: TextAlign.center,
                ),
                onTap: () {
                  showDialog<void>(
                      //<div>Icons made by <a href="https://www.flaticon.com/authors/freepik" title="Freepik">Freepik</a> from <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a></div>
                      context: context,
                      builder: (context) => SimpleDialog(
                            title: Text('Reset settings?'),
                            children: [
                              Image.asset(
                                "assets/images/sun.png",
                                fit: BoxFit.contain,
                              ),
                              Image.asset(
                                "assets/images/moon.png",
                                fit: BoxFit.contain,
                              ),
                              FlatButton(
                                textColor: Color(0xFF6200EE),
                                onPressed: () {
                                  themeProvider.setLightTheme();
                                },
                                child: Text('Light'),
                              ),
                              FlatButton(
                                textColor: Color(0xFF6200EE),
                                onPressed: () {
                                  themeProvider.setDarkTheme();
                                },
                                child: Text('Dark'),
                              ),
                            ],
                          ));
                },
              ),
              ListTile(
                title: Row(
                  children: [
                    Icon(Icons.info),
                    Text('Item 2'),
                  ],
                ),
                onTap: () {
                  print("works");
                },
              ),
              // Drawer
            ],
          ),
        ),
      ),
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
