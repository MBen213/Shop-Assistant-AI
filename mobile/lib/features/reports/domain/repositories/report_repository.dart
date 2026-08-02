import '../entities/report_statistics.dart';

abstract class ReportRepository {
  Future<ReportStatistics> getStatistics();
}