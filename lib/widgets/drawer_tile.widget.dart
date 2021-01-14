import 'package:flutter/material.dart';
import 'package:gita_app/config/sizing.config.dart';

class DrawerTile extends StatelessWidget {
  DrawerTile({
    Key key,
    @required this.title,
    @required this.onTap,
  }) : super(key: key);
  final String title;

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          Icon(
            Icons.home,
            color: Theme.of(context).buttonColor,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: SizeConfig.heightMultiplier),
          ),
          Text(title),
        ],
      ),
      onTap: onTap,
    );
  }
}
