import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:pencilwith/models/chapterobject.dart';
import 'package:pencilwith/models/noteobject.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static final DBHelper dbHelper = DBHelper._internal();
  static Database _db;

  String tableName = 'ProjectNote';
  String tableName2 = 'ChapterNote';

  DBHelper._internal();

  factory DBHelper() {
    return dbHelper;
  }

  //singleton---

  Future<Database> get db async {
    if (_db == null) {
      _db = await initDatabase();
    }
    return _db;
  }

  Future<Database> initDatabase() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + "SavedDatabase.db";

    var manager = openDatabase(path, version: 1, onCreate: _onCreate);
    return manager;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        'create table $tableName (id TEXT NOT NULL, div TEXT NOT NULL, title TEXT, content TEXT not null, date text, done text )');
    await db.execute(
        'create table ChapterNote (id TEXT NOT NULL, idx text not null, title TEXT not null, content TEXT not null, date text)');
  }

  Future<int> insertNote(NoteObject note) async {
    Database db = await this.db;
    var result = await db.insert(tableName, note.toJson());
    return result;
  }

  Future<List> getNotes(String index) async {
    Database db = await this.db;
    var result = await db.rawQuery('select * from $tableName where id=$index');
    return result;
  }

  //---------------------------------

  Future<int> insertChapter(ChapterObject chapter) async {
    Database db = await this.db;
    var result = await db.insert(tableName2, chapter.toJson());
    return result;
  }

  Future<List> getChapter(String index) async {
    Database db = await this.db;
    var result = await db.rawQuery('select * from $tableName2 where id=$index');
    return result;
  }

  Future<int> getAllCount(String index) async {
    Database db = await this.db;
    var result =
        await db.rawQuery('select id from $tableName2 where id=$index');
    return result.length;
  }

  Future<List> getEachChapter(String index, String eachIndex) async {
    Database db = await this.db;
    var result = await db.rawQuery(
        'select * from $tableName2 where id=$index and idx=$eachIndex');
    return result;
  }
}
