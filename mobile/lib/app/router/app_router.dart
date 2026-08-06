import 'package:flutter/material.dart';

import '../../features/users/presentation/pages/login_page.dart';
import '../../features/users/presentation/pages/splash_page.dart';

import '../../features/dashboard/presentation/pages/dashboard_page.dart';

import '../../features/products/presentation/pages/products_page.dart';
import '../../features/users/presentation/pages/users_page.dart';

import '../../features/sales/presentation/pages/sales_page.dart';

import '../../features/store_settings/presentation/pages/store_settings_page.dart';
import '../../features/app_settings/presentation/pages/app_settings_page.dart';

class AppRouter {
  AppRouter._();

  static const splash = '/';

  static const login = '/login';

  static const dashboard = '/dashboard';

  static const products = '/products';

  static const users = '/users';

  static const sales = '/sales';

  static const storeSettings = '/store-settings';

  static const appSettings = '/app-settings';

  static final Map<String, WidgetBuilder> routes = {
    splash: (_) => const SplashPage(),

    login: (_) => const LoginPage(),

    dashboard: (_) => const DashboardPage(),

    products: (_) => const ProductsPage(),

    users: (_) => const UsersPage(),

    sales: (_) => const SalesPage(),

    storeSettings: (_) => const StoreSettingsPage(),

    appSettings: (_) => const AppSettingsPage(),
  };
}