import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Databasehelper {
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await initDatabase();

    return _database;
  }

  initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();

    String path = join(directory.path, 'noteDatabase.db');
    print("database path ${path}");

    var db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE note1 (id INTEGER PRIMARY KEY, name TEXT not null, email TEXT not null)');
    });
    return db;
  }
}
