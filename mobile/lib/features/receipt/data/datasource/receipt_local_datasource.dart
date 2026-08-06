import '../../../../core/database/database_helper.dart';

import '../../domain/entities/receipt.dart';
import '../../domain/entities/receipt_item.dart';

class ReceiptLocalDataSource {
  final DatabaseHelper databaseHelper;

  ReceiptLocalDataSource({
    DatabaseHelper? databaseHelper,
  }) : databaseHelper =
            databaseHelper ?? DatabaseHelper.instance;

  Future<Receipt?> getReceipt(
    String saleId,
  ) async {
    final db = await databaseHelper.database;

    //==========================
    // SALE
    //==========================

    final saleResult = await db.query(
      'sales',
      where: 'id = ?',
      whereArgs: [saleId],
      limit: 1,
    );

    if (saleResult.isEmpty) {
      return null;
    }

    final sale = saleResult.first;

    //==========================
    // ITEMS
    //==========================

    final itemsResult = await db.query(
      'sale_items',
      where: 'sale_id = ?',
      whereArgs: [saleId],
      orderBy: 'id ASC',
    );

    final items = itemsResult
        .map(
          (e) => ReceiptItem(
            productId: e['product_id'] as String,
            productName: e['product_name'] as String,
            price: (e['price'] as num).toDouble(),
            quantity: e['quantity'] as int,
          ),
        )
        .toList();

    return Receipt(
      id: sale['id'] as String,
      createdAt: DateTime.parse(
        sale['created_at'] as String,
      ),
      total: (sale['total'] as num).toDouble(),
      items: items,
    );
  }
}