import 'dart:convert';

import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class DBHelper {
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();

    return sql.openDatabase(path.join(dbPath, 'MyToDo.db'),
        onCreate: (db, version) {
      db.execute(
          'CREATE TABLE task_types(id integer PRIMARY KEY not null, title TEXT, description TEXT)');
      db.execute(
          'CREATE TABLE tasks(id integer PRIMARY KEY not null, typeId integer, title TEXT, description TEXT, createDate TEXT, updateDate TEXT, isCompleted integer)');
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }

  static Future<List<Map<String, dynamic>>> rawQuery(String sql) async {
    final db = await DBHelper.database();
    return await db.rawQuery(sql);
  }
}
