import '../../domain/entities/dashboard_statistics.dart';

class DashboardRemoteDataSource {
  Future<DashboardStatistics> getStatistics() async {
    await Future.delayed(const Duration(seconds: 1));

    return const DashboardStatistics(
      todaySales: 12500,
      totalOrders: 38,
      totalProfit: 4200,
      totalProducts: 156,
    );
  }
}