import 'package:flutter/material.dart';

import '../../data/datasource/report_local_datasource.dart';
import '../../data/repositories/report_repository_impl.dart';
import '../../domain/entities/report_statistics.dart';
import '../../domain/usecases/get_statistics_usecase.dart';

class ReportsProvider extends ChangeNotifier {
  ReportsProvider() {
    final repository = ReportRepositoryImpl(
      ReportLocalDataSource(),
    );

    _getStatisticsUseCase = GetStatisticsUseCase(repository);
  }

  late final GetStatisticsUseCase _getStatisticsUseCase;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  ReportStatistics? _statistics;

  ReportStatistics? get statistics => _statistics;

  Future<void> loadStatistics() async {
    _isLoading = true;
    notifyListeners();

    _statistics = await _getStatisticsUseCase();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> refresh() async {
    await loadStatistics();
  }
}