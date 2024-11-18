import 'package:flutter/material.dart';
import 'package:nhp/model/customer.dart';
import 'package:nhp/pro/counter.dart';
import 'package:nhp/pro/favourite_provider.dart';
import 'package:nhp/pro/theme_provider.dart';
import 'package:nhp/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'details.dart';
import 'flutter_clipboard/flutter_clibboard.dart';
import 'login_screen.dart/first.dart';
import 'login_screen.dart/steak_track_page.dart';
import 'pro/screen/change_theme.dart';
import 'pro/screen/counter_screen.dart';
import 'pro/screen/favourite_item_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // var counter = CounterProvider();
  // await counter.loadCounter();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => CounterProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => FavouriteProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      darkTheme: ThemeData.dark(
        useMaterial3: true,
      ),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      themeMode: provider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      //  home: SplashScreen(),

      home: ChangeTheme(),
    );
  }
}
