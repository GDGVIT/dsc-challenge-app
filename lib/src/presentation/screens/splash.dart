import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

import 'home_screen.dart';
import 'signup/signup_screen_goog.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    checkLogin();
    setState(() {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ));
    });
    super.initState();
  }

  checkLogin() async {
    Box hiveInstance = await Hive.openBox("userBox");
    bool isLoggedIn = hiveInstance.get("logged_in");
    if (isLoggedIn == false || isLoggedIn == null) {
      Future.delayed(Duration(milliseconds: 200), () {
        Navigator.of(context).pushReplacementNamed(SignupScreen.routename);
      });
    } else {
      // Scaffold.of(context).showSnackBar(
      //     getMySnackBar("Welcome back, ${hiveInstance.get("display_name")}"));
      Future.delayed(Duration(milliseconds: 200), () {
        Navigator.of(context).pushReplacementNamed(HomeScreen.routename);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(),
      ),
    );
  }
}
