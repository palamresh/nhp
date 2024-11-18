import 'package:flutter/material.dart';
import 'package:nhp/pro/theme_provider.dart';
import 'package:provider/provider.dart';

class ChangeTheme extends StatefulWidget {
  const ChangeTheme({super.key});

  @override
  State<ChangeTheme> createState() => ChangeThemeState();
}

class ChangeThemeState extends State<ChangeTheme> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Change Theme"),
      ),
      body: Column(
        children: [
          Switch(
              value: provider.isDarkMode,
              onChanged: (value) {
                provider.toggleTheme();
              })
        ],
      ),
    );
  }
}
