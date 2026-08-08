import 'package:sqflite/sqflite.dart';

import 'base_dao.dart';
import '../tables/customers_table.dart';

class CustomersDao extends BaseDao {
  CustomersDao._();

  static final CustomersDao instance = CustomersDao._();

  // ==========================
  // CREATE
  // ==========================

  Future<int> insert(
    Map<String, dynamic> customer,
  ) async {
    final database = await db;

    return database.insert(
      CustomersTable.tableName,
      customer,
      conflictAlgorithm: ConflictAlgorithm.abort,
    );
  }

  // ==========================
  // READ
  // ==========================

  Future<List<Map<String, dynamic>>> getAll() async {
    final database = await db;

    return database.query(
      CustomersTable.tableName,
      orderBy: 'name ASC',
    );
  }

  Future<Map<String, dynamic>?> getById(
    String id,
  ) async {
    final database = await db;

    final result = await database.query(
      CustomersTable.tableName,
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (result.isEmpty) {
      return null;
    }

    return result.first;
  }

  Future<Map<String, dynamic>?> getByPhone(
    String phone,
  ) async {
    final database = await db;

    final result = await database.query(
      CustomersTable.tableName,
      where: 'phone = ?',
      whereArgs: [phone],
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
    final database = await db;

    return database.query(
      CustomersTable.tableName,
      where: 'name LIKE ? OR phone LIKE ?',
      whereArgs: [
        '%$keyword%',
        '%$keyword%',
      ],
      orderBy: 'name ASC',
    );
  }

  Future<bool> exists(
    String id,
  ) async {
    final database = await db;

    final result = await database.query(
      CustomersTable.tableName,
      columns: ['id'],
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    return result.isNotEmpty;
  }

  // ==========================
  // UPDATE
  // ==========================

  Future<int> update(
    Map<String, dynamic> customer,
  ) async {
    final database = await db;

    return database.update(
      CustomersTable.tableName,
      customer,
      where: 'id = ?',
      whereArgs: [customer['id']],
    );
  }

  Future<int> updateDebt(
    String id,
    double debt,
  ) async {
    final database = await db;

    return database.update(
      CustomersTable.tableName,
      {
        'debt': debt,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> increaseDebt(
    String id,
    double amount,
  ) async {
    final database = await db;

    return database.rawUpdate(
      '''
      UPDATE ${CustomersTable.tableName}
      SET debt = debt + ?
      WHERE id = ?
      ''',
      [
        amount,
        id,
      ],
    );
  }

  Future<int> decreaseDebt(
    String id,
    double amount,
  ) async {
    final database = await db;

    return database.rawUpdate(
      '''
      UPDATE ${CustomersTable.tableName}
      SET debt = debt - ?
      WHERE id = ?
      ''',
      [
        amount,
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
    final database = await db;

    return database.delete(
      CustomersTable.tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> clear() async {
    final database = await db;

    return database.delete(
      CustomersTable.tableName,
    );
  }

  // ==========================
  // STATISTICS
  // ==========================

  Future<int> count() async {
    final database = await db;

    final result = await database.rawQuery(
      '''
      SELECT COUNT(*)
      FROM ${CustomersTable.tableName}
      ''',
    );

    return Sqflite.firstIntValue(result) ?? 0;
  }

  Future<double> totalDebt() async {
    final database = await db;

    final result = await database.rawQuery(
      '''
      SELECT SUM(debt)
      FROM ${CustomersTable.tableName}
      ''',
    );

    final value = result.first.values.first;

    if (value == null) {
      return 0;
    }

    return (value as num).toDouble();
  }

  Future<List<Map<String, dynamic>>> getCustomersWithDebt() async {
    final database = await db;

    return database.query(
      CustomersTable.tableName,
      where: 'debt > ?',
      whereArgs: [0],
      orderBy: 'debt DESC',
    );
  }
}