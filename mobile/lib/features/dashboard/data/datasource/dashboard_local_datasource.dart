import '../../../../core/database/dao/customers_dao.dart';
import '../../../../core/database/dao/products_dao.dart';
import '../../../../core/database/dao/sales_dao.dart';
import '../../../../core/database/dao/suppliers_dao.dart';

import '../../domain/entities/dashboard_stats.dart';

class DashboardLocalDataSource {
  DashboardLocalDataSource();

  Future<DashboardStats> getDashboardStats() async {
    final products = await ProductsDao.instance.count();
    final customers = await CustomersDao.instance.count();
    final suppliers = await SuppliersDao.instance.count();
    final sales = await SalesDao.instance.count();

    final revenue = await SalesDao.instance.revenue();
    final lowStock = await ProductsDao.instance.lowStockCount();
    final todaySales = await SalesDao.instance.todayCount();
    final todayRevenue = await SalesDao.instance.todayRevenue();

    // سيتم حساب الربح لاحقاً بواسطة ReportsDao
    const double todayProfit = 0.0;

    return DashboardStats(
      totalProducts: products,
      totalCustomers: customers,
      totalSuppliers: suppliers,
      totalSales: sales,
      totalRevenue: revenue,
      lowStockProducts: lowStock,
      todaySales: todaySales,
      todayRevenue: todayRevenue,
      todayProfit: todayProfit,
    );
  }
}