import 'package:sqflite/sqflite.dart';

import '../../../../core/database/database_helper.dart';
import '../../../products/data/models/product_model.dart';
import '../models/stock_movement_model.dart';

class InventoryLocalDataSource {
  Future<Database> get _db async =>
      DatabaseHelper.instance.database;

  Future<List<ProductModel>> getLowStockProducts() async {
    final db = await _db;

    final result = await db.query(
      'products',
      where: 'quantity <= ?',
      whereArgs: [5],
      orderBy: 'quantity ASC',
    );

    return result
        .map((e) => ProductModel.fromMap(e))
        .toList();
  }

  Future<List<StockMovementModel>> getStockMovements() async {
    final db = await _db;

    final result = await db.query(
      'stock_movements',
      orderBy: 'created_at DESC',
    );

    return result
        .map((e) => StockMovementModel.fromMap(e))
        .toList();
  }

  Future<void> restockProduct({
    required ProductModel product,
    required int quantity,
  }) async {
    final db = await _db;

    await db.transaction((txn) async {
      await txn.update(
        'products',
        {
          'quantity': product.quantity + quantity,
        },
        where: 'id = ?',
        whereArgs: [product.id],
      );

      await txn.insert(
        'stock_movements',
        {
          'id': DateTime.now()
              .millisecondsSinceEpoch
              .toString(),
          'product_id': product.id,
          'product_name': product.name,
          'quantity_added': quantity,
          'created_at':
              DateTime.now().toIso8601String(),
        },
      );
    });
  }
}