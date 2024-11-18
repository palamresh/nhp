import 'package:flutter/material.dart';
import 'package:nhp/login.dart';
import 'package:nhp/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MyHomePage"),
        actions: [
          IconButton(
              onPressed: () async {
                var sp = await SharedPreferences.getInstance();
                sp.remove(SplashScreenState.loginKey).then((value) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                      (routes) => false);
                });
              },
              icon: Icon(Icons.logout))
        ],
      ),
    );
  }
}
