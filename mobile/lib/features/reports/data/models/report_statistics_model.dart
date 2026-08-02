import '../../domain/entities/report_statistics.dart';

class ReportStatisticsModel extends ReportStatistics {
  const ReportStatisticsModel({
    required super.todaySales,
    required super.todayProfit,
    required super.totalProducts,
    required super.totalCustomers,
    required super.lowStockProducts,
  });

  factory ReportStatisticsModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return ReportStatisticsModel(
      todaySales: (map['todaySales'] as num).toDouble(),
      todayProfit: (map['todayProfit'] as num).toDouble(),
      totalProducts: map['totalProducts'] as int,
      totalCustomers: map['totalCustomers'] as int,
      lowStockProducts: map['lowStockProducts'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'todaySales': todaySales,
      'todayProfit': todayProfit,
      'totalProducts': totalProducts,
      'totalCustomers': totalCustomers,
      'lowStockProducts': lowStockProducts,
    };
  }
}