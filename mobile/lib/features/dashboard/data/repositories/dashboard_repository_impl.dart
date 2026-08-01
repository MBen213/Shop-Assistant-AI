import '../../domain/entities/dashboard_statistics.dart';
import '../../domain/repositories/dashboard_repository.dart';
import '../datasource/dashboard_remote_datasource.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardRemoteDataSource remoteDataSource;

  DashboardRepositoryImpl(this.remoteDataSource);

  @override
  Future<DashboardStatistics> getStatistics() {
    return remoteDataSource.getStatistics();
  }
}