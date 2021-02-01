import 'package:flutter/material.dart';
import 'package:gita_app/config/global_strings.config.dart';
import 'package:gita_app/config/sizing.config.dart';
import 'package:gita_app/providers/language.provider.dart';
import 'package:provider/provider.dart';

class SelectLanguageDialog extends StatelessWidget {
  const SelectLanguageDialog({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LanguageProvider languageProvider = Provider.of<LanguageProvider>(context);
    final bool isHindi = languageProvider.isHindi;

    return SimpleDialog(
      title: Text(
        GlobalStrings.data[languageProvider.currentLanguage]["language"],
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline6,
      ),
      titlePadding: EdgeInsets.all(4 * SizeConfig.heightMultiplier),
      children: [
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () => languageProvider.setHindi(),
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      height: 15 * SizeConfig.heightMultiplier,
                      width: 15 * SizeConfig.heightMultiplier,
                      padding: EdgeInsets.all(SizeConfig.heightMultiplier),
                      margin: EdgeInsets.all(SizeConfig.heightMultiplier),
                      decoration: BoxDecoration(
                        color: isHindi ? Theme.of(context).selectedRowColor : Theme.of(context).dialogBackgroundColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Text(
                          "अ",
                          style: TextStyle(
                            fontSize: 10 * SizeConfig.textMultiplier,
                            color: Theme.of(context).primaryColorDark,
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => languageProvider.setEnglish(),
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      height: 15 * SizeConfig.heightMultiplier,
                      width: 15 * SizeConfig.heightMultiplier,
                      padding: EdgeInsets.all(SizeConfig.heightMultiplier),
                      margin: EdgeInsets.all(SizeConfig.heightMultiplier),
                      decoration: BoxDecoration(
                        color: !isHindi ? Theme.of(context).selectedRowColor : Theme.of(context).dialogBackgroundColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Text(
                          "A",
                          style: TextStyle(
                            fontSize: 10 * SizeConfig.textMultiplier,
                            color: Theme.of(context).primaryColorDark,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
