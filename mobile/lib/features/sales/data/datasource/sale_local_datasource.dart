import 'package:sqflite/sqflite.dart';

import '../../../../core/database/database_helper.dart';
import '../models/sale_item_model.dart';
import '../models/sale_model.dart';

class SaleLocalDataSource {
  Future<Database> get _db async => DatabaseHelper.instance.database;

  // ============================================================
  // Get Sales
  // ============================================================

  Future<List<SaleModel>> getSales() async {
    final db = await _db;

    final sales = await db.query(
      'sales',
      orderBy: 'created_at DESC',
    );

    final List<SaleModel> result = [];

    for (final sale in sales) {
      final items = await db.query(
        'sale_items',
        where: 'sale_id = ?',
        whereArgs: [sale['id']],
      );

      result.add(
        SaleModel.fromMap(
          sale,
          items
              .map((e) => SaleItemModel.fromMap(e))
              .toList(),
        ),
      );
    }

    return result;
  }

  // ============================================================
  // Complete Sale
  // ============================================================

  Future<void> completeSale(SaleModel sale) async {
    final db = await _db;

    await db.transaction((txn) async {
      // حفظ الفاتورة

      await txn.insert(
        'sales',
        sale.toMap(),
      );

      // حفظ المنتجات وخصم الكمية

      for (final item in sale.items) {
        final saleItem = SaleItemModel.fromEntity(item);

        final map = saleItem.toMap();

        map['id'] =
            '${sale.id}_${item.productId}';

        map['sale_id'] = sale.id;

        map['subtotal'] = item.subtotal;

        await txn.insert(
          'sale_items',
          map,
        );

        await txn.rawUpdate(
          '''
          UPDATE products
          SET quantity = quantity - ?
          WHERE id = ?
          ''',
          [
            item.quantity,
            item.productId,
          ],
        );
      }
    });
  }

  // ============================================================
  // Delete Sale
  // ============================================================

  Future<void> deleteSale(String id) async {
    final db = await _db;

    await db.delete(
      'sales',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // ============================================================
  // Compatibility
  // ============================================================

  Future<void> addSale(SaleModel sale) async {
    await completeSale(sale);
  }
}