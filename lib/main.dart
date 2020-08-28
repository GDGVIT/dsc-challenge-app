import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'src/presentation/screens/daily_challenge/new_challenge.dart';
import 'src/presentation/screens/home_screen.dart';
import 'src/presentation/screens/profile_screen.dart';
import 'src/presentation/screens/signup/instagram_handle.dart';
import 'src/presentation/screens/signup/signup_screen_goog.dart';
import 'src/presentation/screens/splash.dart';
import 'src/presentation/screens/weekly_challenge/new_challenge.dart';
import 'src/utils/global_themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
  final dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  await Hive.openBox("userBox");
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
        NewWeeklyChallengeScreen.routename: (_) => NewWeeklyChallengeScreen(),
      },
    );
  }
}
