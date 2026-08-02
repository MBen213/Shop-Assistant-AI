class ReportStatistics {
  final double todaySales;
  final double todayProfit;

  final int totalProducts;
  final int totalCustomers;
  final int lowStockProducts;

  const ReportStatistics({
    required this.todaySales,
    required this.todayProfit,
    required this.totalProducts,
    required this.totalCustomers,
    required this.lowStockProducts,
  });
}