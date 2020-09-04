import 'package:flutter/material.dart';

Color primaryColor = Color(0xff40a5f4);

Color accentColor = Color(0xff0077c1);

Color lightBlue = Color(0xff7fd6ff);

Color canvasColor = Color(0xfff2f2f2);

Color disabledGrey = Color(0xffbbbbbb);

BorderRadius borderRadius8 = BorderRadius.circular(8);
BorderRadius borderRadiusButton = BorderRadius.circular(50);

TextStyle boldHeading = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
);

TextStyle bigText = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.normal,
);

TextStyle greyText = TextStyle(
  color: Colors.grey[700],
);

final ThemeData appThemeData = ThemeData(
  fontFamily: 'Montserrat',
  primaryColor: primaryColor,
  accentColor: accentColor,
  canvasColor: canvasColor,
  dialogTheme: DialogTheme(
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: borderRadius8,
    ),
  ),
  buttonTheme: ButtonThemeData(
    disabledColor: disabledGrey,
    buttonColor: primaryColor,
    // te1xtTheme: ButtonTextTheme.primary,
    shape: RoundedRectangleBorder(
      borderRadius: borderRadius8,
    ),
  ),
  pageTransitionsTheme: PageTransitionsTheme(
    builders: {
      TargetPlatform.android: ZoomPageTransitionsBuilder(),
    },
  ),
  appBarTheme: AppBarTheme(
    color: canvasColor,
    elevation: 0,
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: borderRadius8,
      borderSide: BorderSide.none,
    ),
    fillColor: Colors.white,
    filled: true,
  ),
);
