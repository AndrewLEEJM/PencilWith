import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:pencilwith/models/noteobject.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static final DBHelper dbHelper = DBHelper._internal();
  static Database _db;

  String tableName = 'ProjectNote';

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
  }

  Future<int> insertNote(NoteObject note) async {
    Database db = await this.db;
    var result = await db.insert(tableName, note.toJson());
    return result;
  }

  Future<List> getNotes(String index) async {
    Database db = await this.db;
    var result = await db.rawQuery('select * from ProjectNote where id=$index');
    return result;
  }
}
