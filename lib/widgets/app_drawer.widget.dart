import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gita_app/config/sizing.config.dart';
import 'package:gita_app/models/GitaData.dart';
import 'package:gita_app/providers/theme.provider.dart';
import 'package:gita_app/screens/chapters.screen.dart';
import 'package:gita_app/screens/home.screen.dart';
import 'package:gita_app/widgets/drawer_tile.widget.dart';
import 'package:gita_app/widgets/select_theme.widget.dart';
import 'package:gita_app/widgets/select_verse.widget.dart';
import 'package:provider/provider.dart';

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
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            buildDrawerImage(),
            buildDrawerTitle(context),
            DrawerTile(
              title: "Home",
              onTap: () {
                Navigator.of(context).pop();
              },
              icon: Icons.home,
            ),
            DrawerTile(
              title: "List of Chapters",
              onTap: () {
                Navigator.of(context).popAndPushNamed(ChaptersScreen.routeName);
              },
              icon: Icons.list,
            ),
            DrawerTile(
              title: "Go to Verse",
              onTap: () {
                showDialog(context: context, child: SelectVerseDialog());
              },
              icon: Icons.forward,
            ),
            DrawerTile(
              title: "Theme",
              onTap: () {
                showDialog<void>(
                    //<div>Icons made by <a href="https://www.flaticon.com/authors/freepik" title="Freepik">Freepik</a> from <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a></div>
                    context: context,
                    builder: (context) => SelectThemeDialog());
              },
              icon: Icons.color_lens,
            ),
            DrawerTile(
              title: "Language",
              onTap: () {
                // Provider.of<GitaData>(context, listen: false).reloadData(context);
              },
              icon: Icons.language,
            ),
            DrawerTile(title: "About Gita", onTap: () {}, icon: Icons.library_books),
            DrawerTile(title: "About Developer", onTap: () {}, icon: Icons.developer_board),
            DrawerTile(title: "App Info", onTap: () {}, icon: Icons.info),
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
