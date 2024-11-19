import 'dart:io';

import 'package:nhp/sql_lite/notes';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBhelper {
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }

    _db = await initDatabase();
    return _db;
  }

  Future initDatabase() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = join(dir.path, 'notes.db');
    var db = await openDatabase(path, version: 1, onCreate: onCreate);
    return db;
  }

  onCreate(Database db, int version) async {
    await db.execute(
        "create table notes (id integer primary key autoincrement,title Text not null,age integer not null,email Text not null,description Text not null) ");
  }

  Future<NotesModel> insertdb(NotesModel notesModel) async {
    var dbClient = await db;

    await dbClient!.insert("notes", notesModel.toMap());

    return notesModel;
  }

  Future<List<NotesModel>> retriveData() async {
    var dbClient = await db;

    List<Map<String, Object?>> queryResult = await dbClient!.query(
      "notes",
    );

    return queryResult.map((e) => NotesModel.fromMap(e)).toList();
  }

  Future<int> delete(int? id) async {
    var dbClient = await db;

    return await dbClient!.delete("notes", where: "id=?", whereArgs: [id]);
  }

  Future<int> updateNotes(NotesModel noteModel) async {
    var dbClient = await db;

    return await dbClient!.update('notes', noteModel.toMap(),
        where: 'id=?', whereArgs: [noteModel.id]);
  }
}
