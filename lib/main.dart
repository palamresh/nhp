import 'package:flutter/material.dart';

import 'package:nhp/json_learn/json_screen.dart';

import 'package:nhp/pro/counter.dart';
import 'package:nhp/pro/favourite_provider.dart';
import 'package:nhp/pro/screen/task_provider.dart';
import 'package:nhp/pro/theme_provider.dart';

import 'package:provider/provider.dart';

import 'new_sql_db/add_sql.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => CounterProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => FavouriteProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => TaskProvider()..loadTask(),
      ),
      ChangeNotifierProvider(
        create: (context) => ThemeProvider()..loadTheme(),
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
    if (provider.loading) {
      return MaterialApp(
        home: Scaffold(
          body: Center(
            child: Text("Loading...."),
          ),
        ),
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      darkTheme: ThemeData(
          appBarTheme: AppBarTheme(backgroundColor: Colors.green),
          brightness: Brightness.dark),
      theme: ThemeData(
        appBarTheme: AppBarTheme(backgroundColor: Colors.blue),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      themeMode: provider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      //  home: SplashScreen(),

      home: AddSql(),
    );
  }
}
