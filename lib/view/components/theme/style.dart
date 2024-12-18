import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

final BorderRadius radius = BorderRadius.circular(6.0);

final ThemeData appTheme = ThemeData.light().copyWith(
  scaffoldBackgroundColor: backgroundColor,
  primaryColor: mainColor,

  ///appBar theme
  appBarTheme: AppBarTheme(
    color: transparentColor,
    elevation: 0.0,
  ),

  ///text theme
  textTheme: GoogleFonts.openSansTextTheme().copyWith(
    titleMedium: TextStyle(color: disabledTextColor),
    bodySmall: TextStyle(color: disabledTextColor),
    bodyLarge: TextStyle(fontSize: 16.0),
    titleLarge: TextStyle(fontSize: 18.0),
    labelLarge: TextStyle(fontSize: 16.0, letterSpacing: 1),
    titleSmall: TextStyle(),
    bodyMedium: TextStyle(),
  ), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: mainColor),
);

/// NAME         SIZE  WEIGHT  SPACING
/// headline1    96.0  light   -1.5
/// headline2    60.0  light   -0.5
/// headline3    48.0  regular  0.0
/// headline4    34.0  regular  0.25
/// headline5    24.0  regular  0.0
/// headline6    20.0  medium   0.15
/// subtitle1    16.0  regular  0.15
/// subtitle2    14.0  medium   0.1
/// body1        16.0  regular  0.5   (bodyText1)
/// body2        14.0  regular  0.25  (bodyText2)
/// button       14.0  medium   1.25
/// caption      12.0  regular  0.4
/// overline     10.0  regular  1.5
