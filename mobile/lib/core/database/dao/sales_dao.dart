import 'package:sqflite/sqflite.dart';

import '../database_helper.dart';
import '../tables/sales_table.dart';
import '../tables/sale_items_table.dart';

class SalesDao {
  SalesDao._();

  static final SalesDao instance = SalesDao._();

  Future<Database> get _db async {
    return DatabaseHelper.instance.database;
  }

  // ====================================================
  // CREATE SALE
  // ====================================================

  Future<void> insertSale(
    Map<String, dynamic> sale,
    List<Map<String, dynamic>> items,
  ) async {
    final db = await _db;

    await db.transaction((txn) async {
      // --------------------------------------------------
      // 1. Insert sale
      // --------------------------------------------------

      await txn.insert(
        SalesTable.tableName,
        sale,
        conflictAlgorithm: ConflictAlgorithm.abort,
      );

      // --------------------------------------------------
      // 2. Process sale items
      // --------------------------------------------------

      for (final item in items) {
        final productId = item['product_id'] as String;
        final quantity = item['quantity'] as int;

        // ------------------------------------------------
        // Validate quantity
        // ------------------------------------------------

        if (quantity <= 0) {
          throw Exception(
            'Sale quantity must be greater than zero.',
          );
        }

        // ------------------------------------------------
        // 3. Decrease product stock
        // ------------------------------------------------

        final updatedRows = await txn.rawUpdate(
          '''
          UPDATE products
          SET quantity = quantity - ?
          WHERE id = ?
          AND quantity >= ?
          ''',
          [
            quantity,
            productId,
            quantity,
          ],
        );

        // ------------------------------------------------
        // 4. Make sure stock was actually updated
        // ------------------------------------------------

        if (updatedRows == 0) {
          throw Exception(
            'Insufficient stock for product: $productId',
          );
        }

        // ------------------------------------------------
        // 5. Insert sale item
        // ------------------------------------------------

        await txn.insert(
          SaleItemsTable.tableName,
          item,
          conflictAlgorithm: ConflictAlgorithm.abort,
        );
      }
    });
  }

  // ====================================================
  // READ SALES
  // ====================================================

  Future<List<Map<String, dynamic>>> getSales() async {
    final db = await _db;

    return db.query(
      SalesTable.tableName,
      orderBy: 'created_at DESC',
    );
  }

  // ====================================================
  // READ SALE ITEMS
  // ====================================================

  Future<List<Map<String, dynamic>>> getItems(
    String saleId,
  ) async {
    final db = await _db;

    return db.query(
      SaleItemsTable.tableName,
      where: 'sale_id = ?',
      whereArgs: [saleId],
      orderBy: 'id ASC',
    );
  }

  // ====================================================
  // GET SALE BY ID
  // ====================================================

  Future<Map<String, dynamic>?> getById(
    String id,
  ) async {
    final db = await _db;

    final result = await db.query(
      SalesTable.tableName,
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (result.isEmpty) {
      return null;
    }

    return result.first;
  }

  // ====================================================
  // DELETE SALE
  // ====================================================

  Future<void> deleteSale(
    String id,
  ) async {
    final db = await _db;

    await db.transaction((txn) async {
      // ------------------------------------------------
      // 1. Get sale items before deleting the sale
      // ------------------------------------------------

      final items = await txn.query(
        SaleItemsTable.tableName,
        where: 'sale_id = ?',
        whereArgs: [id],
      );

      // ------------------------------------------------
      // 2. Restore product stock
      // ------------------------------------------------

      for (final item in items) {
        final productId = item['product_id'] as String;
        final quantity = item['quantity'] as int;

        await txn.rawUpdate(
          '''
          UPDATE products
          SET quantity = quantity + ?
          WHERE id = ?
          ''',
          [
            quantity,
            productId,
          ],
        );
      }

      // ------------------------------------------------
      // 3. Delete sale
      //
      // sale_items will be deleted automatically because
      // sale_items.sale_id has ON DELETE CASCADE.
      // ------------------------------------------------

      await txn.delete(
        SalesTable.tableName,
        where: 'id = ?',
        whereArgs: [id],
      );
    });
  }

  // ====================================================
  // STATISTICS
  // ====================================================

  Future<int> count() async {
    final db = await _db;

    final result = await db.rawQuery(
      '''
      SELECT COUNT(*)
      FROM ${SalesTable.tableName}
      ''',
    );

    return Sqflite.firstIntValue(result) ?? 0;
  }

  // ====================================================
  // TOTAL REVENUE
  // ====================================================

  Future<double> revenue() async {
    final db = await _db;

    final result = await db.rawQuery(
      '''
      SELECT COALESCE(SUM(total), 0)
      FROM ${SalesTable.tableName}
      ''',
    );

    return (result.first.values.first as num?)?.toDouble() ?? 0.0;
  }

  // ====================================================
  // TODAY SALES COUNT
  // ====================================================

  Future<int> todayCount() async {
    final db = await _db;

    final today = DateTime.now()
        .toIso8601String()
        .substring(0, 10);

    final result = await db.rawQuery(
      '''
      SELECT COUNT(*)
      FROM ${SalesTable.tableName}
      WHERE substr(created_at, 1, 10) = ?
      ''',
      [today],
    );

    return Sqflite.firstIntValue(result) ?? 0;
  }

  // ====================================================
  // TODAY REVENUE
  // ====================================================

  Future<double> todayRevenue() async {
    final db = await _db;

    final today = DateTime.now()
        .toIso8601String()
        .substring(0, 10);

    final result = await db.rawQuery(
      '''
      SELECT COALESCE(SUM(total), 0)
      FROM ${SalesTable.tableName}
      WHERE substr(created_at, 1, 10) = ?
      ''',
      [today],
    );

    return (result.first.values.first as num?)?.toDouble() ?? 0.0;
  }
}