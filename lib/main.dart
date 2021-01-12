import 'package:flutter/material.dart';
import 'package:gita_app/config/sizing.config.dart';
import 'package:gita_app/config/styling.config.dart';
import 'package:gita_app/models/GitaData.dart';
import 'package:gita_app/providers/data.provider.dart';
import 'package:gita_app/providers/progress.provider.dart';
import 'package:gita_app/providers/theme.provider.dart';
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
    return MultiProvider(
      providers: [
        FutureProvider(create: (context) => DataProvider().loadGitaData(context)),
        Provider(create: (_) => ProgressProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: LayoutBuilder(
        builder: (context, constraints) {
          return OrientationBuilder(
            builder: (context, orientation) {
              SizeConfig().init(constraints, orientation);
              final bool themeIsDark = Provider.of<ThemeProvider>(context).isDark;
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Gita',
                theme: themeIsDark ? AppTheme.darkTheme : AppTheme.lightTheme,
                home: Provider<ProgressProvider>(
                  create: (_) => ProgressProvider(),
                  child: HomeScreen(),
                ),
                routes: {
                  ChaptersScreen.routeName: (context) => ChaptersScreen(),
                  ChapterDetailScreen.routeName: (context) => ChapterDetailScreen(),
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
