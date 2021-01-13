import 'package:flutter/material.dart';
import 'package:gita_app/config/sizing.config.dart';
import 'package:gita_app/models/GitaData.dart';
import 'package:gita_app/providers/theme.provider.dart';
import 'package:gita_app/screens/home.screen.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: Container(
        color: Theme.of(context).cardColor,
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 50 * SizeConfig.imageSizeMultiplier,
              child: DrawerHeader(
                margin: EdgeInsets.zero,
                padding: EdgeInsets.zero,
                child: Image.asset(
                  "assets/images/krishna.jpg",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            ListTile(
              title: Text(
                'जय श्री कृष्णा',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.home,
                    color: Theme.of(context).buttonColor,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: SizeConfig.heightMultiplier),
                  ),
                  Text('Home'),
                ],
              ),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
              },
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(
                    Icons.list,
                    color: Theme.of(context).buttonColor,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: SizeConfig.heightMultiplier),
                  ),
                  Text('List of Chapters'),
                ],
              ),
              onTap: () {
                print("works");
              },
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(
                    Icons.arrow_circle_up,
                    color: Theme.of(context).buttonColor,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: SizeConfig.heightMultiplier),
                  ),
                  Text('Go to verse'),
                ],
              ),
              onTap: () {
                print("works");
              },
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(
                    Icons.color_lens,
                    color: Theme.of(context).buttonColor,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: SizeConfig.heightMultiplier),
                  ),
                  Text(
                    'Theme',
                  ),
                ],
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
                  Icon(
                    Icons.language,
                    color: Theme.of(context).buttonColor,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: SizeConfig.heightMultiplier),
                  ),
                  Text('Language'),
                ],
              ),
              onTap: () {
                Provider.of<GitaData>(context, listen: false).reloadData(context);
              },
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(
                    Icons.library_books,
                    color: Theme.of(context).buttonColor,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: SizeConfig.heightMultiplier),
                  ),
                  Text('About Gita'),
                ],
              ),
              onTap: () {
                print("works");
              },
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(
                    Icons.developer_board,
                    color: Theme.of(context).buttonColor,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: SizeConfig.heightMultiplier),
                  ),
                  Text('About Developer'),
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
    );
  }
}
