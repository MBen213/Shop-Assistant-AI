import 'package:sqflite/sqflite.dart';

import '../../../../core/database/database_helper.dart';
import '../models/sale_item_model.dart';
import '../models/sale_model.dart';

class SaleLocalDataSource {
  Future<Database> get _db async => DatabaseHelper.instance.database;

  /// ==========================
  /// Get All Sales
  /// ==========================
  Future<List<SaleModel>> getSales() async {
    final db = await _db;

    final salesResult = await db.query(
      'sales',
      orderBy: 'created_at DESC',
    );

    List<SaleModel> sales = [];

    for (final saleMap in salesResult) {
      final itemsResult = await db.query(
        'sale_items',
        where: 'sale_id = ?',
        whereArgs: [saleMap['id']],
      );

      final items = itemsResult
          .map((e) => SaleItemModel.fromMap(e))
          .toList();

      sales.add(
        SaleModel.fromMap(
          saleMap,
          items,
        ),
      );
    }

    return sales;
  }

  /// ==========================
  /// Complete Sale
  /// ==========================
  Future<void> completeSale(SaleModel sale) async {
    final db = await _db;

    await db.transaction((txn) async {
      await txn.insert(
        'sales',
        sale.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      for (final item in sale.items) {
        final saleItem = SaleItemModel.fromEntity(item);

        await txn.insert(
          'sale_items',
          {
            ...saleItem.toMap(),
            'sale_id': sale.id,
            'subtotal': saleItem.subtotal,
          },
          conflictAlgorithm: ConflictAlgorithm.replace,
        );

        await txn.rawUpdate(
          '''
          UPDATE products
          SET quantity = quantity - ?
          WHERE id = ?
          ''',
          [
            saleItem.quantity,
            saleItem.productId,
          ],
        );
      }
    });
  }

  /// ==========================
  /// Delete Sale
  /// ==========================
  Future<void> deleteSale(String id) async {
    final db = await _db;

    await db.transaction((txn) async {
      await txn.delete(
        'sale_items',
        where: 'sale_id = ?',
        whereArgs: [id],
      );

      await txn.delete(
        'sales',
        where: 'id = ?',
        whereArgs: [id],
      );
    });
  }
}