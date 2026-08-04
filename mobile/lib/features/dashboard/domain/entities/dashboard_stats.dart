class DashboardStats {
  final int totalProducts;
  final int totalCustomers;
  final int totalSuppliers;
  final int totalSales;
  final double totalRevenue;
  final double totalPurchases;
  final int lowStockProducts;

  const DashboardStats({
    required this.totalProducts,
    required this.totalCustomers,
    required this.totalSuppliers,
    required this.totalSales,
    required this.totalRevenue,
    required this.totalPurchases,
    required this.lowStockProducts,
  });

  factory DashboardStats.empty() {
    return const DashboardStats(
      totalProducts: 0,
      totalCustomers: 0,
      totalSuppliers: 0,
      totalSales: 0,
      totalRevenue: 0,
      totalPurchases: 0,
      lowStockProducts: 0,
    );
  }
}