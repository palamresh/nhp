import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CounterProvider extends ChangeNotifier {
  int count = 0;
  loadCounter() async {
    var pref = await SharedPreferences.getInstance();

    count = await pref.getInt("counter") ?? 0;
    notifyListeners();
  }

  int get _count => count;
  void increate() async {
    count++;
    notifyListeners();
    await _saveCounter();
  }

  void decreament() async {
    if (count > 0) {
      count--;
      notifyListeners();
      await _saveCounter();
    }
  }

  _saveCounter() async {
    var pref = await SharedPreferences.getInstance();

    await pref.setInt("counter", count);
  }
}
