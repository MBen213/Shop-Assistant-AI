import 'package:sqflite/sqflite.dart';

import '../database_helper.dart';

class SuppliersDao {
  SuppliersDao._();

  static final SuppliersDao instance = SuppliersDao._();

  Future<Database> get _db async =>
      DatabaseHelper.instance.database;

  // ==========================
  // CREATE
  // ==========================

  Future<int> insert(
    Map<String, dynamic> supplier,
  ) async {
    final db = await _db;

    return db.insert(
      'suppliers',
      supplier,
      conflictAlgorithm: ConflictAlgorithm.abort,
    );
  }

  // ==========================
  // READ
  // ==========================

  Future<List<Map<String, dynamic>>> getAll() async {
    final db = await _db;

    return db.query(
      'suppliers',
      orderBy: 'name ASC',
    );
  }

  Future<Map<String, dynamic>?> getById(
    String id,
  ) async {
    final db = await _db;

    final result = await db.query(
      'suppliers',
      where: 'id=?',
      whereArgs: [id],
      limit: 1,
    );

    if (result.isEmpty) {
      return null;
    }

    return result.first;
  }

  Future<List<Map<String, dynamic>>> search(
    String keyword,
  ) async {
    final db = await _db;

    return db.query(
      'suppliers',
      where: 'name LIKE ? OR phone LIKE ?',
      whereArgs: [
        '%$keyword%',
        '%$keyword%',
      ],
      orderBy: 'name ASC',
    );
  }

  // ==========================
  // UPDATE
  // ==========================

  Future<int> update(
    Map<String, dynamic> supplier,
  ) async {
    final db = await _db;

    return db.update(
      'suppliers',
      supplier,
      where: 'id=?',
      whereArgs: [supplier['id']],
    );
  }

  // ==========================
  // DELETE
  // ==========================

  Future<int> delete(
    String id,
  ) async {
    final db = await _db;

    return db.delete(
      'suppliers',
      where: 'id=?',
      whereArgs: [id],
    );
  }

  // ==========================
  // STATISTICS
  // ==========================

  Future<int> count() async {
    final db = await _db;

    final result = await db.rawQuery(
      'SELECT COUNT(*) FROM suppliers',
    );

    return Sqflite.firstIntValue(result) ?? 0;
  }
}