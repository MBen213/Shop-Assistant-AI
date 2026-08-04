import 'package:flutter/material.dart';

import '../../domain/entities/dashboard_stats.dart';
import '../../domain/usecases/get_dashboard_stats_usecase.dart';

class DashboardProvider extends ChangeNotifier {
  DashboardProvider({
    required this.getDashboardStatsUseCase,
  });

  final GetDashboardStatsUseCase getDashboardStatsUseCase;

  DashboardStats _stats = DashboardStats.empty();
  DashboardStats get stats => _stats;

  bool _loading = false;
  bool get loading => _loading;

  String? _error;
  String? get error => _error;

  Future<void> loadDashboard() async {
    try {
      _loading = true;
      _error = null;
      notifyListeners();

      _stats = await getDashboardStatsUseCase();
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> refresh() async {
    await loadDashboard();
  }
}