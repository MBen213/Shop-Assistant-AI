import '../../../../core/database/database_helper.dart';
import '../../domain/entities/dashboard_stats.dart';

class DashboardLocalDataSource {
  final DatabaseHelper databaseHelper;

  DashboardLocalDataSource(this.databaseHelper);

  Future<DashboardStats> getDashboardStats() async {
    final products = await databaseHelper.getProductsCount();
    final customers = await databaseHelper.getCustomersCount();
    final suppliers = await databaseHelper.getSuppliersCount();
    final sales = await databaseHelper.getSalesCount();
    
    final revenue = await databaseHelper.getRevenue();
    final lowStock = await databaseHelper.getLowStockProductsCount();
    final todaySales = await databaseHelper.getTodaySalesCount();
    final todayRevenue = await databaseHelper.getTodayRevenue();
    final todayProfit = await databaseHelper.getTodayProfit();

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