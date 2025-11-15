import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../models/task.dart';

class SQLiteService {
  static Database? _database;
  static const String _tableName = 'tasks';

  Future<Database> get database async {
    if (kIsWeb) {
      throw UnsupportedError(
        'SQLite não é suportado em web. Use FileStorage ou SharedPreferences ao invés.',
      );
    }

    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'tasks.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_tableName (
            id TEXT PRIMARY KEY,
            title TEXT NOT NULL,
            done INTEGER NOT NULL
          )
        ''');
      },
    );
  }

  Future<void> insert(Task task) async {
    if (kIsWeb) {
      throw UnsupportedError('Use FileStorage ao invés de SQLite em web');
    }
    final db = await database;
    await db.insert(
      _tableName,
      task.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Task>> loadTasks() async {
    if (kIsWeb) {
      throw UnsupportedError('Use FileStorage ao invés de SQLite em web');
    }
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(_tableName);
    return maps.map((map) => Task.fromJson(map)).toList();
  }

  Future<void> update(Task task) async {
    if (kIsWeb) {
      throw UnsupportedError('Use FileStorage ao invés de SQLite em web');
    }
    final db = await database;
    await db.update(
      _tableName,
      task.toJson(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future<void> delete(String id) async {
    if (kIsWeb) {
      throw UnsupportedError('Use FileStorage ao invés de SQLite em web');
    }
    final db = await database;
    await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}