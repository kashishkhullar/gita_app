import 'package:flutter/material.dart';
import 'package:gita_app/config/global_strings.config.dart';
import 'package:gita_app/config/sizing.config.dart';
import 'package:gita_app/models/Verse.dart';
import 'package:gita_app/providers/language.provider.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class VerseCard extends StatelessWidget {
  const VerseCard({
    Key key,
    @required PanelController pc,
    @required this.verse,
  })  : _pc = pc,
        super(key: key);

  final PanelController _pc;
  final Verse verse;

  @override
  Widget build(BuildContext context) {
    final LanguageProvider languageProvider = Provider.of<LanguageProvider>(context);
    return Card(
      color: Theme.of(context).cardColor,
      margin: EdgeInsets.symmetric(vertical: 9 * SizeConfig.heightMultiplier),
      elevation: 10,
      shadowColor: Theme.of(context).shadowColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      child: InkWell(
        onTap: () => _pc.open(),
        borderRadius: BorderRadius.circular(50),
        splashColor: Theme.of(context).primaryColorLight,
        focusColor: Theme.of(context).focusColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: SizeConfig.heightMultiplier),
              child: Text(
                "${GlobalStrings.data[languageProvider.currentLanguage]["verse"]} ${verse.verseNumber}",
                style: TextStyle(
                  fontSize: languageProvider.isHindi ? 8 * SizeConfig.textMultiplier : 6 * SizeConfig.textMultiplier,
                  color: Theme.of(context).primaryColorDark,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: SizeConfig.heightMultiplier),
              child: FittedBox(
                fit: BoxFit.cover,
                child: Text(
                  verse.text,
                  // style: TextStyle(fontSize: 6 * SizeConfig.textMultiplier),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
