import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskProvider with ChangeNotifier {
  List<String> _tasks = [];

  List<String> get tasts => _tasks;

  void loadTask() async {
    var pref = await SharedPreferences.getInstance();
    _tasks = pref.getStringList("takst") ?? [];
    notifyListeners();
  }

  void addTask(String item) async {
    _tasks.add(item);

    notifyListeners();
    var pref = await SharedPreferences.getInstance();
    await pref.setStringList("takst", _tasks);
  }

  Future<void> removeTask(int index) async {
    _tasks.removeAt(index);
    notifyListeners();
    var pref = await SharedPreferences.getInstance();
    await pref.setStringList("takst", _tasks);
  }
}
