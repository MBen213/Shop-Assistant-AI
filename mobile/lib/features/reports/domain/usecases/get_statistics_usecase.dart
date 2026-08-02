import '../entities/report_statistics.dart';
import '../repositories/report_repository.dart';

class GetStatisticsUseCase {
  final ReportRepository repository;

  GetStatisticsUseCase(this.repository);

  Future<ReportStatistics> call() {
    return repository.getStatistics();
  }
}