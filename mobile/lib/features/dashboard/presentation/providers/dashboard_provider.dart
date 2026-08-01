import 'package:flutter/material.dart';

import '../../data/datasource/dashboard_remote_datasource.dart';
import '../../data/repositories/dashboard_repository_impl.dart';
import '../../domain/entities/dashboard_statistics.dart';
import '../../domain/usecases/get_dashboard_statistics.dart';

class DashboardProvider extends ChangeNotifier {
  DashboardStatistics? statistics;

  bool isLoading = false;

  final GetDashboardStatistics _getStatistics =
      GetDashboardStatistics(
        DashboardRepositoryImpl(
          DashboardRemoteDataSource(),
        ),
      );

  Future<void> loadDashboard() async {
    isLoading = true;
    notifyListeners();

    statistics = await _getStatistics();

    isLoading = false;
    notifyListeners();
  }
}