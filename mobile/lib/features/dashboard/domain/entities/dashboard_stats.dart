class DashboardStats {
  final int totalProducts;
  final int totalCustomers;
  final int totalSuppliers;
  final int totalSales;

  final double totalRevenue;

  final int lowStockProducts;

  // Today's Statistics
  final int todaySales;
  final double todayRevenue;
  final double todayProfit;

  const DashboardStats({
    required this.totalProducts,
    required this.totalCustomers,
    required this.totalSuppliers,
    required this.totalSales,
    required this.totalRevenue,
    required this.lowStockProducts,
    required this.todaySales,
    required this.todayRevenue,
    required this.todayProfit,
  });

  factory DashboardStats.empty() {
    return const DashboardStats(
      totalProducts: 0,
      totalCustomers: 0,
      totalSuppliers: 0,
      totalSales: 0,
      totalRevenue: 0,
      lowStockProducts: 0,
      todaySales: 0,
      todayRevenue: 0,
      todayProfit: 0,
    );
  }
}