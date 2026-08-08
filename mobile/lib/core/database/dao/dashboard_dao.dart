import 'package:sqflite/sqflite.dart';

import 'base_dao.dart';

class DashboardDao extends BaseDao {
  DashboardDao._();

  static final DashboardDao instance = DashboardDao._();

  // ==========================
  // COUNTS
  // ==========================

  Future<int> getProductsCount() async {
    final database = await db;

    final result = await database.rawQuery(
      'SELECT COUNT(*) FROM products',
    );

    return Sqflite.firstIntValue(result) ?? 0;
  }

  Future<int> getCustomersCount() async {
    final database = await db;

    final result = await database.rawQuery(
      'SELECT COUNT(*) FROM customers',
    );

    return Sqflite.firstIntValue(result) ?? 0;
  }

  Future<int> getSuppliersCount() async {
    final database = await db;

    final result = await database.rawQuery(
      'SELECT COUNT(*) FROM suppliers',
    );

    return Sqflite.firstIntValue(result) ?? 0;
  }

  Future<int> getSalesCount() async {
    final database = await db;

    final result = await database.rawQuery(
      'SELECT COUNT(*) FROM sales',
    );

    return Sqflite.firstIntValue(result) ?? 0;
  }

  Future<int> getPurchasesCount() async {
    final database = await db;

    final result = await database.rawQuery(
      'SELECT COUNT(*) FROM purchases',
    );

    return Sqflite.firstIntValue(result) ?? 0;
  }

  Future<int> getLowStockProductsCount() async {
    final database = await db;

    final result = await database.rawQuery(
      '''
      SELECT COUNT(*)
      FROM products
      WHERE quantity <= 5
      ''',
    );

    return Sqflite.firstIntValue(result) ?? 0;
  }

  // ==========================
  // REVENUE
  // ==========================

  Future<double> getRevenue() async {
    final database = await db;

    final result = await database.rawQuery(
      'SELECT SUM(total) FROM sales',
    );

    final value = result.first.values.first;

    if (value == null) {
      return 0;
    }

    return (value as num).toDouble();
  }

  // ==========================
  // TODAY
  // ==========================

  Future<int> getTodaySalesCount() async {
    final database = await db;

    final today = DateTime.now()
        .toIso8601String()
        .substring(0, 10);

    final result = await database.rawQuery(
      '''
      SELECT COUNT(*)
      FROM sales
      WHERE substr(created_at,1,10)=?
      ''',
      [today],
    );

    return Sqflite.firstIntValue(result) ?? 0;
  }

  Future<double> getTodayRevenue() async {
    final database = await db;

    final today = DateTime.now()
        .toIso8601String()
        .substring(0, 10);

    final result = await database.rawQuery(
      '''
      SELECT SUM(total)
      FROM sales
      WHERE substr(created_at,1,10)=?
      ''',
      [today],
    );

    final value = result.first.values.first;

    if (value == null) {
      return 0;
    }

    return (value as num).toDouble();
  }

  Future<double> getTodayProfit() async {
    // سيتم حسابه لاحقًا بعد اكتمال SalesDao
    return 0;
  }
}