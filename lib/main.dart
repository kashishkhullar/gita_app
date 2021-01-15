import 'package:flutter/material.dart';
import 'package:gita_app/config/sizing.config.dart';
import 'package:gita_app/config/styling.config.dart';
import 'package:gita_app/providers/data.provider.dart';
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
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        FutureProvider(create: (context) => StorageProvider.getStorage()),
        FutureProvider(create: (context) => DataProvider().loadGitaData(context)),
        ChangeNotifierProxyProvider<StorageProvider, ThemeProvider>(
          create: (context) => ThemeProvider(null),
          update: (context, storageProvider, themeProvider) => ThemeProvider(storageProvider),
        ),
        ChangeNotifierProxyProvider<StorageProvider, ProgressProvider>(
          create: (context) => ProgressProvider(null),
          update: (context, storageProvider, progressProvider) => ProgressProvider(storageProvider),
        )
      ],
      child: LayoutBuilder(
        builder: (context, constraints) {
          return OrientationBuilder(
            builder: (context, orientation) {
              SizeConfig().init(constraints, orientation);
              return Consumer2<StorageProvider, ThemeProvider>(builder: (context, storage, themeProvider, __) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Gita',
                  theme: themeProvider.isDark ? AppTheme.darkTheme : AppTheme.lightTheme,
                  home: HomeScreen(),
                  routes: {
                    HomeScreen.routeName: (context) => HomeScreen(),
                    ChaptersScreen.routeName: (context) => ChaptersScreen(),
                    ChapterDetailScreen.routeName: (context) => ChapterDetailScreen(),
                    VersesScreen.routeName: (context) => VersesScreen(),
                  },
                );
              });
            },
          );
        },
      ),
    );
  }
}
