import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDB{

  static Database? _db;
  Future <Database?> get db async{
    if(_db == null){
      _db = await initialDatabase();
      return _db;
    } else {
      return _db;
    }
  }

  initialDatabase () async {
    String databasePath = await getDatabasesPath ();
    String path = join (databasePath, 'english.db');
    Database database = await openDatabase (
        path, onCreate: _onCreate,
        version: 1,
        onUpgrade: _onUpgrade
    );
    return database;
  }

  _onCreate (Database db, int version) async {
    await db.execute (
      ''' CREATE TABLE sentences (
       id INTEGER PRIMARY KEY, 
       sentence TEXT NOT NULL,
       translate TEXT NOT NULL) 
    ''');
    await db.execute (
        ''' CREATE TABLE words (
       id INTEGER PRIMARY KEY, 
       word TEXT NOT NULL,
       translate TEXT NOT NULL) 
    ''');
    debugPrint('Database Created');
  }

  _onUpgrade (Database db, int oldVersion, int newVersion) async {
    await db.execute ('ALTER TABLE notes ADD COLUMN title TEXT');
    debugPrint ("Upgraded");
  }

  readData (String sql) async {
    Database? myDb = await db;
    List <Map> response = await myDb!.rawQuery(sql);
    return response;
  }

  insertData (String sql) async {
    Database? myDb = await db;
    int response = await myDb!.rawInsert(sql);
    return response;
  }

  updateData (String sql)  async {
    Database? myDb = await db;
    int response = await myDb!.rawUpdate(sql);
    return response;
  }

  deleteData (String sql) async {
    Database? myDb = await db;
    int response = await myDb!.rawDelete(sql);
    return response;
  }

  myDeleteDatabase () async {
    String databasePath = await getDatabasesPath ();
    String path = join (databasePath, 'english.db');
    await deleteDatabase (path);
  }

}