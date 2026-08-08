import 'package:sqflite/sqflite.dart';

import '../database_helper.dart';
import '../tables/products_table.dart';
import '../tables/purchases_table.dart';
import '../tables/purchase_items_table.dart';

class PurchasesDao {
  PurchasesDao._();

  static final PurchasesDao instance = PurchasesDao._();

  Future<Database> get _db async => DatabaseHelper.instance.database;

  Future<void> insertPurchase(
    Map<String, dynamic> purchase,
    List<Map<String, dynamic>> items,
  ) async {
    final db = await _db;

    await db.transaction((txn) async {
      await txn.insert(
        PurchasesTable.tableName,
        purchase,
      );

      final batch = txn.batch();

      for (final item in items) {
        batch.insert(
          PurchaseItemsTable.tableName,
          item,
        );

        batch.rawUpdate(
          '''
          UPDATE ${ProductsTable.tableName}
          SET quantity = quantity + ?
          WHERE id = ?
          ''',
          [
            item['quantity'],
            item['product_id'],
          ],
        );
      }

      await batch.commit(noResult: true);
    });
  }

  Future<List<Map<String, dynamic>>> getPurchases() async {
    final db = await _db;

    return db.query(
      PurchasesTable.tableName,
      orderBy: 'created_at DESC',
    );
  }

  Future<List<Map<String, dynamic>>> getPurchaseItems(
    String purchaseId,
  ) async {
    final db = await _db;

    return db.query(
      PurchaseItemsTable.tableName,
      where: 'purchase_id=?',
      whereArgs: [purchaseId],
    );
  }

  Future<void> deletePurchase(
    String id,
  ) async {
    final db = await _db;

    await db.transaction((txn) async {
      await txn.delete(
        PurchaseItemsTable.tableName,
        where: 'purchase_id=?',
        whereArgs: [id],
      );

      await txn.delete(
        PurchasesTable.tableName,
        where: 'id=?',
        whereArgs: [id],
      );
    });
  }
}