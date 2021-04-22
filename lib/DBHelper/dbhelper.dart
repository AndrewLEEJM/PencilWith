import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:pencilwith/models/savenotes.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static final DBHelper dbHelper = DBHelper._internal();
  static Database _db;

  String tableName = 'Notes';
  String colId = 'id';
  String colData = 'content';

  DBHelper._internal();

  factory DBHelper() {
    return dbHelper;
  }

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
        'create table $tableName ($colId INTEGER PRIMARY KEY, $colData TEXT)');
  }

  Future<int> insertNote(SaveNotes saveNotes) async {
    Database db = await this.db;
    var result = await db.insert(tableName, saveNotes.toMap());
    return result;
  }

  Future<List> getNotes() async {
    Database db = await this.db;
    var result =
        await db.rawQuery('select * from $tableName order by $colId desc');
    return result;
  }
}
