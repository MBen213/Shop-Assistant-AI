import 'package:sqflite/sqflite.dart';

import '../database_helper.dart';
import '../tables/stock_movements_table.dart';

class StockMovementsDao {
  StockMovementsDao._();

  static final StockMovementsDao instance =
      StockMovementsDao._();

  Future<Database> get _db async {
    return await DatabaseHelper.instance.database;
  }

  // ====================================================
  // Insert movement
  // ====================================================

  Future<void> insert(
    Map<String, dynamic> data,
  ) async {
    final db = await _db;

    await db.insert(
      StockMovementsTable.tableName,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // ====================================================
  // Get movements for a product
  // ====================================================

  Future<List<Map<String, dynamic>>> getByProduct(
    String productId,
  ) async {
    final db = await _db;

    return await db.query(
      StockMovementsTable.tableName,
      where: 'product_id = ?',
      whereArgs: [productId],
      orderBy: 'created_at ASC',
    );
  }

  // ====================================================
  // Get current stock
  // ====================================================

  Future<double> getCurrentStock(
    String productId,
  ) async {
    final db = await _db;

    final result = await db.rawQuery(
      '''
      SELECT COALESCE(SUM(quantity), 0) AS stock
      FROM ${StockMovementsTable.tableName}
      WHERE product_id = ?
      ''',
      [productId],
    );

    return (result.first['stock'] as num?)?.toDouble() ?? 0.0;
  }

  // ====================================================
  // Delete movement by ID
  // ====================================================

  Future<void> delete(
    String id,
  ) async {
    final db = await _db;

    await db.delete(
      StockMovementsTable.tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // ====================================================
  // Delete movements by reference
  // ====================================================

  Future<void> deleteByReference(
    String referenceId,
  ) async {
    final db = await _db;

    await db.delete(
      StockMovementsTable.tableName,
      where: 'reference_id = ?',
      whereArgs: [referenceId],
    );
  }

  // ====================================================
  // Get all movements
  // ====================================================

  Future<List<Map<String, dynamic>>> getAll() async {
    final db = await _db;

    return await db.query(
      StockMovementsTable.tableName,
      orderBy: 'created_at DESC',
    );
  }
}