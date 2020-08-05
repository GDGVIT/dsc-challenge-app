import 'package:flutter/material.dart';

import 'src/presentation/screens/home_screen.dart';
import 'src/presentation/screens/profile_screen.dart';
import 'src/presentation/screens/signup/instagram_handle.dart';
import 'src/presentation/screens/signup/signup_screen_goog.dart';
import 'src/utils/global_themes.dart';

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
          // te1xtTheme: ButtonTextTheme.primary,
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
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: borderRadius10,
            borderSide: BorderSide.none,
          ),
          fillColor: Colors.white,
          filled: true,
        ),
      ),
      home: SignupScreen(),
      routes: {
        SignupScreen.routename: (_) => SignupScreen(),
        AddInstagramHandleScreen.routename: (_) => AddInstagramHandleScreen(),
        HomeScreen.routename: (_) => HomeScreen(),
        ProfileScreen.routename: (_) => ProfileScreen(),
      },
    );
  }
}
