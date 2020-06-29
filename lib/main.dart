import 'package:daily_mcq/screens/home_screen.dart';
import 'package:daily_mcq/utils/global_themes.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Montserrat',
        primaryColor: primaryColor,
        accentColor: accentColor,
        canvasColor: canvasColor,
        dialogTheme: DialogTheme(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius10,
          ),
        ),
        buttonTheme: ButtonThemeData(
          disabledColor: disabledGrey,
          buttonColor: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius10,
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
      ),
      home: HomeScreen(),
    );
  }
}
