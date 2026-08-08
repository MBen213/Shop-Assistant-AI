import 'base_dao.dart';

class ReportsDao extends BaseDao {
  ReportsDao._();

  static final ReportsDao instance = ReportsDao._();

  // ==========================
  // DAILY
  // ==========================

  Future<double> getDailyRevenue(
    DateTime date,
  ) async {
    final database = await db;

    final day = date.toIso8601String().substring(0, 10);

    final result = await database.rawQuery(
      '''
      SELECT SUM(total)
      FROM sales
      WHERE substr(created_at,1,10)=?
      ''',
      [day],
    );

    final value = result.first.values.first;

    if (value == null) {
      return 0;
    }

    return (value as num).toDouble();
  }

  // ==========================
  // MONTHLY
  // ==========================

  Future<double> getMonthlyRevenue(
    int year,
    int month,
  ) async {
    final database = await db;

    final monthString =
        '$year-${month.toString().padLeft(2, '0')}';

    final result = await database.rawQuery(
      '''
      SELECT SUM(total)
      FROM sales
      WHERE substr(created_at,1,7)=?
      ''',
      [monthString],
    );

    final value = result.first.values.first;

    if (value == null) {
      return 0;
    }

    return (value as num).toDouble();
  }

  // ==========================
  // YEARLY
  // ==========================

  Future<double> getYearRevenue(
    int year,
  ) async {
    final database = await db;

    final result = await database.rawQuery(
      '''
      SELECT SUM(total)
      FROM sales
      WHERE substr(created_at,1,4)=?
      ''',
      ['$year'],
    );

    final value = result.first.values.first;

    if (value == null) {
      return 0;
    }

    return (value as num).toDouble();
  }

  // ==========================
  // SALES BETWEEN DATES
  // ==========================

  Future<List<Map<String, dynamic>>> getSalesBetween(
    DateTime start,
    DateTime end,
  ) async {
    final database = await db;

    return database.query(
      'sales',
      where: 'created_at BETWEEN ? AND ?',
      whereArgs: [
        start.toIso8601String(),
        end.toIso8601String(),
      ],
      orderBy: 'created_at DESC',
    );
  }

  // ==========================
  // PURCHASES BETWEEN DATES
  // ==========================

  Future<List<Map<String, dynamic>>> getPurchasesBetween(
    DateTime start,
    DateTime end,
  ) async {
    final database = await db;

    return database.query(
      'purchases',
      where: 'date BETWEEN ? AND ?',
      whereArgs: [
        start.toIso8601String(),
        end.toIso8601String(),
      ],
      orderBy: 'date DESC',
    );
  }

  // ==========================
  // EXPENSES
  // ==========================

  Future<double> getExpenses() async {
    final database = await db;

    final result = await database.rawQuery(
      '''
      SELECT SUM(amount)
      FROM expenses
      ''',
    );

    final value = result.first.values.first;

    if (value == null) {
      return 0;
    }

    return (value as num).toDouble();
  }

  // ==========================
  // NET PROFIT
  // ==========================

  Future<double> getNetProfit() async {
    final revenue = await getYearRevenue(
      DateTime.now().year,
    );

    final expenses = await getExpenses();

    return revenue - expenses;
  }

  // ==========================
  // TOP PRODUCTS
  // ==========================

  Future<List<Map<String, dynamic>>> getTopProducts({
    int limit = 10,
  }) async {
    final database = await db;

    return database.rawQuery(
      '''
      SELECT
        product_id,
        product_name,
        SUM(quantity) AS total_quantity,
        SUM(subtotal) AS total_sales
      FROM sale_items
      GROUP BY product_id
      ORDER BY total_quantity DESC
      LIMIT ?
      ''',
      [limit],
    );
  }

  // ==========================
  // LATEST SALES
  // ==========================

  Future<List<Map<String, dynamic>>> getLatestSales({
    int limit = 10,
  }) async {
    final database = await db;

    return database.query(
      'sales',
      orderBy: 'created_at DESC',
      limit: limit,
    );
  }
}