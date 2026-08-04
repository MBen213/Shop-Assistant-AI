import 'package:sqflite/sqflite.dart';

import '../../../../core/database/database_helper.dart';
import '../../domain/entities/dashboard_stats.dart';

class DashboardLocalDataSource {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  Future<DashboardStats> getDashboardStats() async {
    final Database db = await _databaseHelper.database;

    final products = Sqflite.firstIntValue(
          await db.rawQuery(
            'SELECT COUNT(*) FROM products',
          ),
        ) ??
        0;

    final customers = Sqflite.firstIntValue(
          await db.rawQuery(
            'SELECT COUNT(*) FROM customers',
          ),
        ) ??
        0;

    final suppliers = Sqflite.firstIntValue(
          await db.rawQuery(
            'SELECT COUNT(*) FROM suppliers',
          ),
        ) ??
        0;

    final sales = Sqflite.firstIntValue(
          await db.rawQuery(
            'SELECT COUNT(*) FROM sales',
          ),
        ) ??
        0;

    final lowStock = Sqflite.firstIntValue(
          await db.rawQuery(
            'SELECT COUNT(*) FROM products WHERE quantity <= 5',
          ),
        ) ??
        0;

    final revenueResult = await db.rawQuery(
      'SELECT SUM(total) AS total FROM sales',
    );

    final purchasesResult = await db.rawQuery(
      '''
      SELECT SUM(quantity * purchasePrice) AS total
      FROM purchase_items
      ''',
    );

    final totalRevenue =
        (revenueResult.first['total'] as num?)?.toDouble() ?? 0.0;

    final totalPurchases =
        (purchasesResult.first['total'] as num?)?.toDouble() ?? 0.0;

    return DashboardStats(
      totalProducts: products,
      totalCustomers: customers,
      totalSuppliers: suppliers,
      totalSales: sales,
      totalRevenue: totalRevenue,
      totalPurchases: totalPurchases,
      lowStockProducts: lowStock,
    );
  }
}