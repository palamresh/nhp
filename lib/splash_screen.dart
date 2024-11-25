import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nhp/pro/screen/change_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  static const String loginKey = "login";

  @override
  void initState() {
    checkLogin();
    // TODO: implement initState
    super.initState();
  }

  void checkLogin() async {
    Timer(Duration(seconds: 3), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => ChangeTheme(),
          ),
          (routes) => false);
    });
    // SharedPreferences sp = await SharedPreferences.getInstance();

    // var checkLogin = sp.getBool(loginKey);
    // print(checkLogin);
    // Timer(Duration(seconds: 2), () {
    //   if (checkLogin != null) {
    //     if (checkLogin) {
    //       Navigator.pushAndRemoveUntil(
    //           context,
    //           MaterialPageRoute(builder: (context) => MyHomePage()),
    //           (routes) => false);
    //     } else {
    //       Navigator.pushAndRemoveUntil(
    //           context,
    //           MaterialPageRoute(builder: (context) => LoginScreen()),
    //           (routes) => false);
    //     }
    //   } else {
    //     Navigator.pushAndRemoveUntil(
    //         context,
    //         MaterialPageRoute(builder: (context) => LoginScreen()),
    //         (routes) => false);
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Text("Splash Screen"),
    ));
  }
}
