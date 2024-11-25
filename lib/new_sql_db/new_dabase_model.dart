import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

import 'package:sqflite/sqflite.dart';

import 'package:path/path.dart';

class NewDatabaseModel {
  static Database? _database;
  List fetchAllData = [];

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await initDatabase();

    return _database;
  }

  initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, "new.db");
    var newDatabase = openDatabase(path, version: 1, onCreate: create);
    return newDatabase;
  }

  create(Database? db, int version) async {
    await db!.execute(
        'CREATE TABLE Student (id INTEGER PRIMARY KEY, dummyData json)');
  }

  insertData({dummyData}) async {
    var db = await database;

    await db!
        .insert("Student", {"dummyData": jsonEncode(dummyData)}).then((value) {
      print('data is insert');
    }).onError((error, trackError) {
      print(error.toString());
    });
  }

  fetchData() async {
    var db = await database;

    fetchAllData = await db!.query("Student");
    // print(fetchAllData);
  }

  resetTable() async {
    var db = await database;

    await db!.execute('drop table if exists student');

    await db.execute(
        'CREATE TABLE Student (id INTEGER PRIMARY KEY, dummyData json)');
  }

  updateStudent({name, id}) async {
    var db = await database;
    int dbupdate = await db!
        .rawUpdate('update Student set name =? where id =?', [name, id]);

    return dbupdate;
  }

  deletedata({id}) async {
    var db = await database;

    await db!.delete('Student', where: 'id=?', whereArgs: [id]);
    print('delete data');
  }
}
