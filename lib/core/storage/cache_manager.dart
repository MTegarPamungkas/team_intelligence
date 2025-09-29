import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class CacheManager {
  static Database? _database;
  static const String _tableName = 'cache';
  static const String _columnKey = 'key';
  static const String _columnValue = 'value';
  static const String _columnTimestamp = 'timestamp';

  Future<Database> get _db async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'cache.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_tableName (
            $_columnKey TEXT PRIMARY KEY,
            $_columnValue TEXT,
            $_columnTimestamp INTEGER
          )
        ''');
      },
    );
  }

  Future<void> saveCache(String key, dynamic value) async {
    final db = await _db;
    final timestamp = DateTime.now().millisecondsSinceEpoch;

    final String valueString = value is String ? value : jsonEncode(value);

    await db.insert(_tableName, {
      _columnKey: key,
      _columnValue: valueString,
      _columnTimestamp: timestamp,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<dynamic> getCache(String key) async {
    final db = await _db;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: '$_columnKey = ?',
      whereArgs: [key],
    );

    if (maps.isNotEmpty) {
      final data = maps.first[_columnValue] as String;
      try {
        return jsonDecode(data);
      } catch (e) {
        return data;
      }
    }
    return null;
  }

  Future<void> clearCache({Duration? olderThan}) async {
    final db = await _db;
    if (olderThan != null) {
      final threshold = DateTime.now()
          .subtract(olderThan)
          .millisecondsSinceEpoch;
      await db.delete(
        _tableName,
        where: '$_columnTimestamp < ?',
        whereArgs: [threshold],
      );
    } else {
      await db.delete(_tableName);
    }
  }

  Future<void> close() async {
    final db = await _db;
    await db.close();
    _database = null;
  }
}
