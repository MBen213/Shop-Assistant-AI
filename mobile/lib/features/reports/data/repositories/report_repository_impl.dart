import '../../domain/entities/report_statistics.dart';
import '../../domain/repositories/report_repository.dart';
import '../datasource/report_local_datasource.dart';

class ReportRepositoryImpl implements ReportRepository {
  final ReportLocalDataSource localDataSource;

  ReportRepositoryImpl(this.localDataSource);

  @override
  Future<ReportStatistics> getStatistics() async {
    return await localDataSource.getStatistics();
  }
}