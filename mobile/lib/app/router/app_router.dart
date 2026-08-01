import 'package:flutter/material.dart';

import '../../features/authentication/presentation/pages/login_page.dart';
import '../../features/dashboard/presentation/pages/dashboard_page.dart';
class AppRouter {
  static const login = '/';
  static const dashboard = '/dashboard';

  static Map<String, WidgetBuilder> routes = {
    login: (_) => const LoginPage(),
    dashboard: (_) => const DashboardPage(),
  };
}