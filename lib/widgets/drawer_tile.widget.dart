import 'package:flutter/material.dart';
import 'package:gita_app/config/sizing.config.dart';

class DrawerTile extends StatelessWidget {
  DrawerTile({
    Key key,
    @required this.title,
    @required this.onTap,
    @required this.icon,
  }) : super(key: key);
  final String title;

  final Function() onTap;

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          Icon(
            icon,
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
