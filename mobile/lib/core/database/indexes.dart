import 'package:sqflite/sqflite.dart';

class DatabaseIndexes {
  DatabaseIndexes._();

  static Future<void> create(DatabaseExecutor db) async {
    await db.execute(
      '''
      CREATE INDEX IF NOT EXISTS idx_products_barcode
      ON products(barcode);
      ''',
    );

    await db.execute(
      '''
      CREATE INDEX IF NOT EXISTS idx_sales_created_at
      ON sales(created_at);
      ''',
    );

    await db.execute(
      '''
      CREATE INDEX IF NOT EXISTS idx_customers_phone
      ON customers(phone);
      ''',
    );

    await db.execute(
      '''
      CREATE INDEX IF NOT EXISTS idx_suppliers_phone
      ON suppliers(phone);
      ''',
    );

    await db.execute(
      '''
      CREATE INDEX IF NOT EXISTS idx_purchase_created_at
      ON purchases(created_at);
      ''',
    );
  }
}