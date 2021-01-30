import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:gita_app/config/global_strings.config.dart';
import 'package:gita_app/config/sizing.config.dart';
import 'package:gita_app/providers/language.provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DeveloperInfoDialog extends StatelessWidget {
  DeveloperInfoDialog({
    Key key,
  }) : super(key: key);

  final Uri _emailLaunchUri = Uri(
    scheme: 'mailto',
    path: GlobalStrings.email,
    queryParameters: {'subject': GlobalStrings.emailSubject, 'body': GlobalStrings.emailBody},
  );

  _launchUrl(urlString) async {
    await launch(urlString);
  }

  @override
  Widget build(BuildContext context) {
    final LanguageProvider languageProvider = Provider.of<LanguageProvider>(context);

    return SimpleDialog(
      title: Text(
        GlobalStrings.data[languageProvider.currentLanguage]["aboutDeveloper"],
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
                GlobalStrings.data[languageProvider.currentLanguage]["developerInfoLine1"],
                style: Theme.of(context).textTheme.bodyText1,
                textAlign: TextAlign.center,
              ),
              Text(
                GlobalStrings.data[languageProvider.currentLanguage]["developerInfoLine2"],
                style: Theme.of(context).textTheme.bodyText1,
                textAlign: TextAlign.center,
              ),
              SelectableLinkify(
                text: GlobalStrings.email,
                style: Theme.of(context).textTheme.bodyText1,
                textAlign: TextAlign.center,
                onTap: () => _launchUrl(_emailLaunchUri.toString()),
                options: LinkifyOptions(humanize: true),
              ),
              Text(
                GlobalStrings.data[languageProvider.currentLanguage]["developerInfoLine3"],
                style: Theme.of(context).textTheme.bodyText1,
                textAlign: TextAlign.center,
              ),
              SelectableLinkify(
                text: GlobalStrings.github,
                style: Theme.of(context).textTheme.bodyText1,
                textAlign: TextAlign.center,
                onTap: () => _launchUrl(GlobalStrings.github),
              )
            ],
          ),
        ),
      ],
    );
  }
}
