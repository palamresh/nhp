import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavouriteProvider with ChangeNotifier {
  List<String> _favourite = [];

  List<String> get favourite => _favourite;

  void loadFavourite() async {
    var pre = await SharedPreferences.getInstance();
    _favourite = await pre.getStringList(
          "favourite",
        ) ??
        [];
    notifyListeners();
  }

  void addFavourite(String item) async {
    if (!_favourite.contains(item)) {
      _favourite.add(item);
      notifyListeners();

      var pre = await SharedPreferences.getInstance();
      await pre.setStringList("favourite", _favourite);
    }
  }

  void removeFavourite(String item) async {
    if (favourite.contains(item)) {
      _favourite.remove(item);
      notifyListeners();
      var pre = await SharedPreferences.getInstance();
      await pre.setStringList("favourite", _favourite);
    }
  }
}
