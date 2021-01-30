import 'package:flutter/material.dart';
import 'package:gita_app/config/sizing.config.dart';
import 'package:gita_app/config/styling.config.dart';
import 'package:gita_app/models/GitaData.dart';
import 'package:gita_app/providers/data.provider.dart';
import 'package:gita_app/providers/language.provider.dart';
import 'package:gita_app/providers/progress.provider.dart';
import 'package:gita_app/providers/storage.provider.dart';
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
  ThemeData getCurrentTheme(BuildContext context, bool isDark) {
    LanguageProvider languageProvider = Provider.of<LanguageProvider>(context);

    if (isDark) {
      if (languageProvider.isHindi)
        return AppTheme.darkThemeHI;
      else
        return AppTheme.darkThemeEN;
    } else {
      if (languageProvider.isHindi)
        return AppTheme.lightThemeHI;
      else
        return AppTheme.lightThemeEN;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        FutureProvider(create: (context) => StorageProvider.getStorage()),
        ChangeNotifierProvider(create: (context) => GitaData()),
        ChangeNotifierProxyProvider<StorageProvider, ThemeProvider>(
          create: (context) => ThemeProvider(null),
          update: (context, storageProvider, themeProvider) => ThemeProvider(storageProvider),
        ),
        ChangeNotifierProxyProvider<StorageProvider, ProgressProvider>(
          create: (context) => ProgressProvider(null),
          update: (context, storageProvider, progressProvider) => ProgressProvider(storageProvider),
        ),
        ChangeNotifierProxyProvider<StorageProvider, LanguageProvider>(
          create: (context) => LanguageProvider(null),
          update: (context, storageProvider, languageProvider) => LanguageProvider(storageProvider),
        )
      ],
      child: LayoutBuilder(
        builder: (context, constraints) {
          return OrientationBuilder(
            builder: (context, orientation) {
              SizeConfig().init(constraints, orientation);
              return Consumer2<ThemeProvider, LanguageProvider>(
                builder: (context, themeProvider, languageProvider, _) {
                  print("is hindi:" + languageProvider.currentLanguage.toString());
                  Provider.of<GitaData>(context, listen: false).loadData(context, languageProvider.isHindi);

                  // TODO: change the data in the json file for chapter 1 shloka 5 for both languages

                  return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    title: 'Gita',
                    theme: getCurrentTheme(context, themeProvider.isDark),
                    home: HomeScreen(),
                    routes: {
                      HomeScreen.routeName: (context) => HomeScreen(),
                      ChaptersScreen.routeName: (context) => ChaptersScreen(),
                      ChapterDetailScreen.routeName: (context) => ChapterDetailScreen(),
                      VersesScreen.routeName: (context) => VersesScreen(),
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
