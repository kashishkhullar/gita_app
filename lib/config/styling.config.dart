import 'package:flutter/material.dart';
import 'package:gita_app/config/sizing.config.dart';

class AppTheme {
  static const Color appBackgroundColor = Colors.white;

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: appBackgroundColor,
    brightness: Brightness.light,
    primarySwatch: Colors.amber,
    textTheme: lightTextTheme,
    shadowColor: Colors.grey[500],
    cardColor: Colors.white,
    buttonColor: Colors.amber[900],
    focusColor: Colors.white,
  );

  static final TextTheme lightTextTheme = TextTheme(
    headline1: _headlineLight1,
    headline2: _headlineLight2,
    headline3: _headlineLight3,
    headline4: _headlineLight4,
    headline5: _headlineLight5,
    headline6: _headlineLight6,
    bodyText1: _bodyTextLight1,
    bodyText2: _bodyTextLight2,
    overline: _overlineLight,
    button: _buttonLight,
  );

  // TODO: create for dark theme

  static final TextStyle _headlineLight1 = TextStyle(
    color: Colors.white,
    fontSize: 7 * SizeConfig.textMultiplier,
    fontFamily: "Poppins",
    fontWeight: FontWeight.w300,
  );

  static final TextStyle _headlineLight2 = TextStyle(
    color: Colors.amber[900],
    fontSize: 7 * SizeConfig.textMultiplier,
    fontFamily: "Poppins",
    fontWeight: FontWeight.w300,
  );

  static final TextStyle _headlineLight3 = TextStyle(
    color: Colors.amber[600],
    fontSize: 5.5 * SizeConfig.textMultiplier,
    fontFamily: "Mukta",
    fontWeight: FontWeight.bold,
  );

  static final TextStyle _headlineLight4 = TextStyle(
    color: Colors.black,
    fontSize: 4 * SizeConfig.textMultiplier,
    fontWeight: FontWeight.normal,
  );

  static final TextStyle _headlineLight5 = TextStyle(
    color: Colors.amber[900],
    fontSize: 3.5 * SizeConfig.textMultiplier,
    fontFamily: "Poppins",
    fontWeight: FontWeight.normal,
  );

  static final TextStyle _headlineLight6 = TextStyle(
    color: Colors.amber[600],
    fontSize: 3 * SizeConfig.textMultiplier,
    fontFamily: "Poppins",
    fontWeight: FontWeight.normal,
  );

  static final TextStyle _bodyTextLight1 = TextStyle(
    color: Colors.black,
    fontSize: 2.5 * SizeConfig.textMultiplier,
    fontFamily: "Mukta",
  );

  static final TextStyle _bodyTextLight2 = TextStyle(
    color: Colors.black,
    fontSize: 2.2 * SizeConfig.textMultiplier,
  );

  static final TextStyle _buttonLight = TextStyle(
    color: Colors.white,
    fontSize: 3 * SizeConfig.textMultiplier,
  );

  static final TextStyle _overlineLight = TextStyle(
    color: Colors.amber[900],
    fontSize: 1.5 * SizeConfig.textMultiplier,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle _headlineDark1 =
      _headlineDark1.copyWith(color: Colors.amber);
}
