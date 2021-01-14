import 'package:flutter/material.dart';
import 'package:gita_app/config/sizing.config.dart';

class AppTheme {
  // Light Theme

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: appBackgroundColorLight,
    brightness: Brightness.light,
    primarySwatch: Colors.amber,
    textTheme: _lightTextTheme,
    shadowColor: Colors.grey[500],
    cardColor: Colors.white,
    buttonColor: Colors.amber[900],
    focusColor: Colors.white,
    iconTheme: _iconThemeDataLight,
    dividerColor: Colors.black,
    selectedRowColor: Colors.grey[500],
  );

  static const Color appBackgroundColorLight = Colors.white;

  static final TextTheme _lightTextTheme = TextTheme(
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

  static final TextStyle _headlineLight1 = TextStyle(
    color: Colors.white,
    fontSize: 6.5 * SizeConfig.textMultiplier,
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

  static final IconThemeData _iconThemeDataLight = IconThemeData(color: Colors.white);

  // Dark Theme

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: appBackgroundColorDark,
    brightness: Brightness.dark,
    primarySwatch: Colors.amber,
    primaryColor: Color.fromRGBO(18, 18, 18, 1),
    primaryColorLight: Colors.white,
    primaryColorDark: Colors.white,
    accentColor: Colors.amber[300],
    textTheme: _darkTextTheme,
    cardColor: Color.fromRGBO(18, 18, 18, 1),
    buttonColor: Colors.orange[900],
    focusColor: Colors.white,
    iconTheme: _iconThemeDataDark,
    dividerColor: Colors.white,
    selectedRowColor: Colors.grey[500],
  );

  static final Color appBackgroundColorDark = Colors.grey[900];

  static final TextTheme _darkTextTheme = TextTheme(
    headline1: _headlineDark1,
    headline2: _headlineDark2,
    headline3: _headlineDark3,
    headline4: _headlineDark4,
    headline5: _headlineDark5,
    headline6: _headlineDark6,
    bodyText1: _bodyTextDark1,
    bodyText2: _bodyTextDark2,
    overline: _overlineLight,
    button: _buttonDark,
  );

  static final IconThemeData _iconThemeDataDark = IconThemeData(color: Colors.amber[800]);

  static final TextStyle _headlineDark1 = _headlineLight1.copyWith(color: Colors.amber[900]);

  static final TextStyle _headlineDark2 = _headlineLight2;

  static final TextStyle _headlineDark3 = _headlineLight3.copyWith(color: Colors.amber[700]);

  static final TextStyle _headlineDark4 = _headlineLight4.copyWith(color: Colors.white);

  static final TextStyle _headlineDark5 = _headlineLight5;

  static final TextStyle _headlineDark6 = _headlineLight6;

  static final TextStyle _bodyTextDark1 = _bodyTextLight1.copyWith(color: Colors.white);

  static final TextStyle _bodyTextDark2 = _bodyTextLight2.copyWith(color: Colors.white);

  static final TextStyle _buttonDark = _buttonLight.copyWith(color: Colors.white);
}
