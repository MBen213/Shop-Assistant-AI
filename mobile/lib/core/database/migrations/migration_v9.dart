import 'package:sqflite/sqflite.dart';

import '../tables/stock_movements_table.dart';

class MigrationV9 {
  MigrationV9._();

  static Future<void> run(DatabaseExecutor db) async {
    await db.execute(
      StockMovementsTable.createTable,
    );
  }
}