import 'package:flutter/material.dart';
import 'package:gita_app/config/global_strings.config.dart';
import 'package:gita_app/config/sizing.config.dart';

class SelectLanguageDialog extends StatelessWidget {
  const SelectLanguageDialog({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(
        GlobalStrings.language,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline6,
      ),
      titlePadding: EdgeInsets.all(4 * SizeConfig.heightMultiplier),
      children: [
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "यह सुविधा जल्द ही उपलब्ध होगी।",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Text(
                "This feature will be available soon",
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
