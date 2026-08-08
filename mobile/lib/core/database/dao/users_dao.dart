import 'package:sqflite/sqflite.dart';

import '../database_helper.dart';
import '../tables/users_table.dart';

class UsersDao {
  UsersDao._();

  static final UsersDao instance = UsersDao._();

  Future<Database> get _db async => DatabaseHelper.instance.database;

  // ==========================
  // CREATE
  // ==========================

  Future<int> insert(
    Map<String, dynamic> user,
  ) async {
    final db = await _db;

    return db.insert(
      UsersTable.tableName,
      user,
      conflictAlgorithm: ConflictAlgorithm.abort,
    );
  }

  // ==========================
  // READ
  // ==========================

  Future<List<Map<String, dynamic>>> getAll() async {
    final db = await _db;

    return db.query(
      UsersTable.tableName,
      orderBy: 'name ASC',
    );
  }

  Future<Map<String, dynamic>?> getById(
    String id,
  ) async {
    final db = await _db;

    final result = await db.query(
      UsersTable.tableName,
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (result.isEmpty) {
      return null;
    }

    return result.first;
  }

  Future<Map<String, dynamic>?> getByUsername(
    String username,
  ) async {
    final db = await _db;

    final result = await db.query(
      UsersTable.tableName,
      where: 'username = ?',
      whereArgs: [username],
      limit: 1,
    );

    if (result.isEmpty) {
      return null;
    }

    return result.first;
  }

  Future<bool> login(
    String username,
    String password,
  ) async {
    final db = await _db;

    final result = await db.query(
      UsersTable.tableName,
      where: 'username = ? AND password = ?',
      whereArgs: [
        username,
        password,
      ],
      limit: 1,
    );

    return result.isNotEmpty;
  }

  // ==========================
  // UPDATE
  // ==========================

  Future<int> update(
    Map<String, dynamic> user,
  ) async {
    final db = await _db;

    return db.update(
      UsersTable.tableName,
      user,
      where: 'id = ?',
      whereArgs: [
        user['id'],
      ],
    );
  }

  Future<int> changePassword(
    String id,
    String password,
  ) async {
    final db = await _db;

    return db.update(
      UsersTable.tableName,
      {
        'password': password,
      },
      where: 'id = ?',
      whereArgs: [
        id,
      ],
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
      UsersTable.tableName,
      where: 'id = ?',
      whereArgs: [
        id,
      ],
    );
  }

  // ==========================
  // STATISTICS
  // ==========================

  Future<int> count() async {
    final db = await _db;

    final result = await db.rawQuery(
      '''
      SELECT COUNT(*)
      FROM ${UsersTable.tableName}
      ''',
    );

    return Sqflite.firstIntValue(result) ?? 0;
  }
}