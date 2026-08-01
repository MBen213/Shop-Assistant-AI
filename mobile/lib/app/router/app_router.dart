import 'package:flutter/material.dart';

import '../../features/authentication/presentation/pages/login_page.dart';
import '../../features/dashboard/presentation/pages/dashboard_page.dart';
import '../../features/products/presentation/pages/products_page.dart';
import '../../features/sales/presentation/pages/sales_page.dart';

class AppRouter {
  AppRouter._();

  static const String login = '/';
  static const String dashboard = '/dashboard';
  static const String products = '/products';
  static const String sales = '/sales';

  static final Map<String, WidgetBuilder> routes = {
    login: (_) => const LoginPage(),
    dashboard: (_) => const DashboardPage(),
    products: (_) => const ProductsPage(),
    sales: (_) => const SalesPage(),
  };
}