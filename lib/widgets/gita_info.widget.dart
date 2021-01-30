import 'package:flutter/material.dart';
import 'package:gita_app/config/global_strings.config.dart';
import 'package:gita_app/config/sizing.config.dart';
import 'package:gita_app/providers/language.provider.dart';
import 'package:provider/provider.dart';

class GitaInfoDialog extends StatelessWidget {
  const GitaInfoDialog({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LanguageProvider languageProvider = Provider.of<LanguageProvider>(context);

    return SimpleDialog(
      title: Text(
        GlobalStrings.data[languageProvider.currentLanguage]["moreAboutGita"],
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline6,
      ),
      children: [
        Container(
          padding: EdgeInsets.all(2 * SizeConfig.heightMultiplier),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                GlobalStrings.data[languageProvider.currentLanguage]["moreAboutGitaLine1"],
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText2,
              ),
              Text(
                GlobalStrings.data[languageProvider.currentLanguage]["moreAboutGitaLine2"],
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText2,
              ),
              Text(
                GlobalStrings.data[languageProvider.currentLanguage]["moreAboutGitaLine3"],
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
