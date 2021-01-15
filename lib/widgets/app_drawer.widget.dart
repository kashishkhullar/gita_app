import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gita_app/config/global_strings.config.dart';
import 'package:gita_app/config/sizing.config.dart';
import 'package:gita_app/screens/chapters.screen.dart';
import 'package:gita_app/widgets/developer_info.widget.dart';
import 'package:gita_app/widgets/drawer_tile.widget.dart';
import 'package:gita_app/widgets/gita_info.widget.dart';
import 'package:gita_app/widgets/select_language.widget.dart';
import 'package:gita_app/widgets/select_theme.widget.dart';
import 'package:gita_app/widgets/select_verse.widget.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Theme.of(context).cardColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            buildDrawerImage(),
            buildDrawerTitle(context),
            DrawerTile(
              title: GlobalStrings.home,
              onTap: () {
                Navigator.of(context).pop();
              },
              icon: Icons.home,
            ),
            DrawerTile(
              title: GlobalStrings.chapterList,
              onTap: () {
                Navigator.of(context).popAndPushNamed(ChaptersScreen.routeName);
              },
              icon: Icons.list,
            ),
            DrawerTile(
              title: GlobalStrings.goToVerse,
              onTap: () {
                showDialog(context: context, child: SelectVerseDialog());
              },
              icon: Icons.forward,
            ),
            DrawerTile(
              title: GlobalStrings.theme,
              onTap: () {
                showDialog<void>(
                    //<div>Icons made by <a href="https://www.flaticon.com/authors/freepik" title="Freepik">Freepik</a> from <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a></div>
                    context: context,
                    builder: (context) => SelectThemeDialog());
              },
              icon: Icons.color_lens,
            ),
            DrawerTile(
              title: GlobalStrings.language,
              onTap: () {
                showDialog<void>(
                    //<div>Icons made by <a href="https://www.flaticon.com/authors/freepik" title="Freepik">Freepik</a> from <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a></div>
                    context: context,
                    builder: (context) => SelectLanguageDialog());
                // Provider.of<GitaData>(context, listen: false).reloadData(context);
              },
              icon: Icons.language,
            ),
            DrawerTile(
                title: GlobalStrings.moreAboutGita,
                onTap: () {
                  showDialog<void>(context: context, builder: (context) => GitaInfoDialog());
                },
                icon: Icons.library_books),
            DrawerTile(
                title: GlobalStrings.aboutDeveloper,
                onTap: () {
                  showDialog<void>(context: context, builder: (context) => DeveloperInfoDialog());
                },
                icon: Icons.developer_board),
            DrawerTile(
                title: GlobalStrings.appInfo,
                onTap: () {
                  showAboutDialog(
                      context: context,
                      applicationVersion: "1.0.0",
                      applicationIcon: Image.asset(
                        "assets/images/icon.png",
                        fit: BoxFit.fill,
                      ),
                      applicationLegalese: "This app is Open Sourced");
                },
                icon: Icons.info),
          ],
        ),
      ),
    );
  }

  ListTile buildDrawerTitle(BuildContext context) {
    return ListTile(
      title: Text(
        'जय श्री कृष्णा',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline5,
      ),
    );
  }

  Container buildDrawerImage() {
    return Container(
      height: 50 * SizeConfig.imageSizeMultiplier,
      child: DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        child: Image.asset(
          "assets/images/krishna.jpg",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
