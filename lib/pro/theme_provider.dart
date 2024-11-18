import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;

  bool _loading = true;

  bool get loading => _loading;

  bool get isDarkMode => _isDarkMode;

  void loadTheme() async {
    var pref = await SharedPreferences.getInstance();
    _isDarkMode = await pref.getBool("themeMode") ?? false;

    _loading = false;
    print(_isDarkMode);
    notifyListeners();
  }

  void toggleTheme() async {
    _isDarkMode = !isDarkMode;

    var pref = await SharedPreferences.getInstance();
    await pref.setBool("themeMode", _isDarkMode);

    notifyListeners();
  }
}
