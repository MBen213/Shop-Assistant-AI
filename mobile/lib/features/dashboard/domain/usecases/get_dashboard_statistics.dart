import '../entities/dashboard_statistics.dart';
import '../repositories/dashboard_repository.dart';

class GetDashboardStatistics {
  final DashboardRepository repository;

  GetDashboardStatistics(this.repository);

  Future<DashboardStatistics> call() {
    return repository.getStatistics();
  }
}