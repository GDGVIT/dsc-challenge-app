import 'package:daily_mcq/src/presentation/screens/daily_challenge/new_challenge.dart';
import 'package:daily_mcq/src/presentation/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'src/presentation/screens/home_screen.dart';
import 'src/presentation/screens/profile_screen.dart';
import 'src/presentation/screens/signup/instagram_handle.dart';
import 'src/presentation/screens/signup/signup_screen_goog.dart';
import 'src/utils/global_themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  await Hive.openBox("user");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: appThemeData,
      home: SplashScreen(),
      routes: {
        SignupScreen.routename: (_) => SignupScreen(),
        AddInstagramHandleScreen.routename: (_) => AddInstagramHandleScreen(),
        HomeScreen.routename: (_) => HomeScreen(),
        ProfileScreen.routename: (_) => ProfileScreen(),
        NewDailyChallengeScreen.routename: (_) => NewDailyChallengeScreen(),
      },
    );
  }
}
