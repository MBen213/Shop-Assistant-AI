import 'package:sqflite/sqflite.dart';

import '../../../../core/database/database_helper.dart';
import '../models/report_statistics_model.dart';

class ReportLocalDataSource {
  Future<Database> get _db async => DatabaseHelper.instance.database;

  Future<ReportStatisticsModel> getStatistics() async {
    final db = await _db;

    // ==========================
    // Total Products
    // ==========================

    final totalProductsResult = await db.rawQuery(
      '''
      SELECT COUNT(*) AS count
      FROM products
      ''',
    );

    final totalProducts =
        (totalProductsResult.first['count'] as int?) ?? 0;

    // ==========================
    // Total Customers
    // ==========================

    final totalCustomersResult = await db.rawQuery(
      '''
      SELECT COUNT(*) AS count
      FROM customers
      ''',
    );

    final totalCustomers =
        (totalCustomersResult.first['count'] as int?) ?? 0;

    // ==========================
    // Low Stock Products
    // ==========================

    final lowStockResult = await db.rawQuery(
      '''
      SELECT COUNT(*) AS count
      FROM products
      WHERE quantity <= 5
      ''',
    );

    final lowStockProducts =
        (lowStockResult.first['count'] as int?) ?? 0;

    // ==========================
    // Today's Sales
    // ==========================

    final today = DateTime.now().toIso8601String().substring(0, 10);

    final todaySalesResult = await db.rawQuery(
      '''
      SELECT IFNULL(SUM(total),0) AS totalSales
      FROM sales
      WHERE substr(created_at,1,10)=?
      ''',
      [today],
    );

    final todaySales =
        (todaySalesResult.first['totalSales'] as num).toDouble();

    // ==========================
    // Today's Profit
    // ==========================

    final items = await db.rawQuery(
      '''
      SELECT
        sale_items.quantity,
        sale_items.price,
        products.purchase_price
      FROM sale_items
      INNER JOIN products
      ON sale_items.product_id = products.id
      INNER JOIN sales
      ON sales.id = sale_items.sale_id
      WHERE substr(sales.created_at,1,10)=?
      ''',
      [today],
    );

    double profit = 0;

    for (final row in items) {
      final selling =
          (row['price'] as num).toDouble();

      final purchase =
          (row['purchase_price'] as num).toDouble();

      final qty =
          row['quantity'] as int;

      profit += (selling - purchase) * qty;
    }

    return ReportStatisticsModel(
      todaySales: todaySales,
      todayProfit: profit,
      totalProducts: totalProducts,
      totalCustomers: totalCustomers,
      lowStockProducts: lowStockProducts,
    );
  }
}