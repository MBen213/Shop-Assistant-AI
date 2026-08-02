import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/app.dart';

import 'features/products/presentation/providers/products_provider.dart';
import 'features/sales/presentation/providers/sales_provider.dart';
import 'features/customers/presentation/providers/customers_provider.dart';
import 'features/inventory/presentation/providers/inventory_provider.dart';
import 'features/reports/presentation/providers/reports_provider.dart';
import 'features/suppliers/presentation/providers/suppliers_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductsProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) => SalesProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) => CustomersProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) => InventoryProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) => ReportsProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) => SuppliersProvider(),
        ),
      ],
      child: const ShopAssistantApp(),
    ),
  );
}