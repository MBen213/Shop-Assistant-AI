import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/app.dart';

import 'core/di/injection.dart';

import 'features/users/presentation/providers/auth_provider.dart';
import 'features/dashboard/presentation/providers/dashboard_provider.dart';
import 'features/products/presentation/providers/products_provider.dart';
import 'features/sales/presentation/providers/sales_provider.dart';
import 'features/customers/presentation/providers/customers_provider.dart';
import 'features/inventory/presentation/providers/inventory_provider.dart';
import 'features/reports/presentation/providers/reports_provider.dart';
import 'features/suppliers/presentation/providers/suppliers_provider.dart';
import 'features/app_settings/presentation/providers/app_settings_provider.dart';

Future<void> main() async {
  // ====================================================
  // Flutter Initialization
  // ====================================================

  WidgetsFlutterBinding.ensureInitialized();

  // ====================================================
  // Dependency Injection
  // ====================================================

  await initDependencies();

  // ====================================================
  // Run Application
  // ====================================================

  runApp(
    MultiProvider(
      providers: [
        // ==================================================
        // AUTH
        // ==================================================

        ChangeNotifierProvider<AuthProvider>(
          create: (_) => sl<AuthProvider>()
            ..checkSession(),
        ),

        // ==================================================
        // APP SETTINGS
        // ==================================================

        ChangeNotifierProvider<AppSettingsProvider>(
          create: (_) => sl<AppSettingsProvider>(),
        ),

        // ==================================================
        // DASHBOARD
        // ==================================================

        ChangeNotifierProvider<DashboardProvider>(
          create: (_) => sl<DashboardProvider>(),
        ),

        // ==================================================
        // PRODUCTS
        // ==================================================

        ChangeNotifierProvider<ProductsProvider>(
          create: (_) => sl<ProductsProvider>()
            ..loadProducts(),
        ),

        // ==================================================
        // SALES
        // ==================================================

        ChangeNotifierProvider<SalesProvider>(
          create: (_) => SalesProvider(),
        ),

        // ==================================================
        // CUSTOMERS
        // ==================================================

        ChangeNotifierProvider<CustomersProvider>(
          create: (_) => CustomersProvider(),
        ),

        // ==================================================
        // INVENTORY
        // ==================================================

        ChangeNotifierProvider<InventoryProvider>(
          create: (_) => InventoryProvider(),
        ),

        // ==================================================
        // REPORTS
        // ==================================================

        ChangeNotifierProvider<ReportsProvider>(
          create: (_) => ReportsProvider(),
        ),

        // ==================================================
        // SUPPLIERS
        // ==================================================

        ChangeNotifierProvider<SuppliersProvider>(
          create: (_) => SuppliersProvider(),
        ),
      ],

      // ====================================================
      // APP
      // ====================================================

      child: const ShopAssistantApp(),
    ),
  );
}