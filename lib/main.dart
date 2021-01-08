import 'package:flutter/material.dart';
import 'package:gita_app/config/sizing.config.dart';
import 'package:gita_app/config/styling.config.dart';
import 'package:gita_app/models/GitaData.dart';
import 'package:gita_app/providers/data.provider.dart';
import 'package:gita_app/screens/chapter_detail.screen.dart';
import 'package:gita_app/screens/chapters.screen.dart';
import 'package:gita_app/screens/home.screen.dart';
import 'package:gita_app/screens/verses.screen.dart';
import 'package:provider/provider.dart';

void main() {
  // जय श्री कृष्णा
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureProvider<GitaData>(
      create: (context) => DataProvider().loadGitaData(context),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return OrientationBuilder(
            builder: (context, orientation) {
              SizeConfig().init(constraints, orientation);
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Gita',
                theme: AppTheme.lightTheme,
                home: HomeScreen(),
                routes: {
                  ChaptersScreen.routeName: (context) => ChaptersScreen(),
                  ChapterDetailScreen.routeName: (context) =>
                      ChapterDetailScreen(),
                  VersesScreen.routeName: (context) => VersesScreen(),
                },
              );
            },
          );
        },
      ),
    );
  }
}
