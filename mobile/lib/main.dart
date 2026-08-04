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



Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();


  await initDependencies();



  runApp(

    MultiProvider(

      providers: [


        ChangeNotifierProvider(
          create: (_) =>
              sl<AuthProvider>()
              ..checkSession(),
        ),



        ChangeNotifierProvider(
          create: (_) =>
              sl<DashboardProvider>()
              ..loadDashboard(),
        ),



        ChangeNotifierProvider(
          create: (_) =>
              sl<ProductsProvider>()
              ..loadProducts(),
        ),



        ChangeNotifierProvider(
          create: (_) =>
              SalesProvider(),
        ),



        ChangeNotifierProvider(
          create: (_) =>
              CustomersProvider(),
        ),



        ChangeNotifierProvider(
          create: (_) =>
              InventoryProvider(),
        ),



        ChangeNotifierProvider(
          create: (_) =>
              ReportsProvider(),
        ),



        ChangeNotifierProvider(
          create: (_) =>
              SuppliersProvider(),
        ),


      ],


      child: const ShopAssistantApp(),

    ),

  );

}