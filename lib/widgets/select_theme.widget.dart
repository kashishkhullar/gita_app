import 'package:flutter/material.dart';
import 'package:gita_app/providers/theme.provider.dart';
import 'package:provider/provider.dart';

class SelectThemeDialog extends StatelessWidget {
  const SelectThemeDialog({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(
        "Select theme",
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline6,
      ),
      titlePadding: EdgeInsets.all(24),
      children: [
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildSun(context),
              buildMoon(context),
            ],
          ),
        ),
      ],
    );
  }

  InkWell buildMoon(BuildContext context) {
    final ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    final bool isDark = themeProvider.isDark;
    return InkWell(
      onTap: () {
        themeProvider.setDarkTheme();
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isDark ? Theme.of(context).selectedRowColor : Theme.of(context).dialogBackgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        width: 120,
        child: Image.asset(
          "assets/images/moon.png",
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  InkWell buildSun(BuildContext context) {
    final ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    final bool isDark = themeProvider.isDark;
    return InkWell(
      onTap: () {
        themeProvider.setLightTheme();
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isDark ? Theme.of(context).dialogBackgroundColor : Theme.of(context).selectedRowColor,
          borderRadius: BorderRadius.circular(10),
        ),
        width: 120,
        child: Image.asset(
          "assets/images/sun.png",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
