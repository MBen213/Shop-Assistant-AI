import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/router/app_router.dart';
import '../../../../l10n/app_localizations.dart';

import '../../../users/presentation/providers/auth_provider.dart';

import '../../../products/presentation/pages/products_page.dart';
import '../../../sales/presentation/pages/sales_page.dart';
import '../../../customers/presentation/pages/customers_page.dart';
import '../../../suppliers/presentation/pages/suppliers_page.dart';

import '../providers/dashboard_provider.dart';

import '../widgets/dashboard_welcome.dart';
import '../widgets/quick_actions.dart';
import '../widgets/stat_card.dart';
import '../widgets/today_overview.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final authProvider = context.watch<AuthProvider>();
    final currentUser = authProvider.currentUser;

    return Consumer<DashboardProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final stats = provider.stats;

        return Scaffold(
          appBar: AppBar(
            title: Text(l10n.dashboard),
            centerTitle: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.settings),
                tooltip: "Settings",
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AppRouter.appSettings,
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.refresh),
                tooltip: "Refresh",
                onPressed: provider.refresh,
              ),
            ],
          ),
          body: RefreshIndicator(
            onRefresh: provider.refresh,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                DashboardWelcome(
                  userName: currentUser?.fullName ?? "",
                ),

                const SizedBox(height: 20),

                TodayOverview(
                  stats: stats,
                ),

                const SizedBox(height: 24),

                QuickActions(
                  onNewSale: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const SalesPage(),
                      ),
                    );
                  },
                  onAddProduct: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ProductsPage(),
                      ),
                    );
                  },
                  onAddCustomer: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const CustomersPage(),
                      ),
                    );
                  },
                  onAddSupplier: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const SuppliersPage(),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 24),

                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 0.95,
                  children: [
                    StatCard(
                      title: l10n.products,
                      value: stats.totalProducts.toString(),
                      icon: Icons.inventory_2,
                      color: Colors.blue,
                    ),
                    StatCard(
                      title: l10n.customers,
                      value: stats.totalCustomers.toString(),
                      icon: Icons.people,
                      color: Colors.orange,
                    ),
                    StatCard(
                      title: l10n.suppliers,
                      value: stats.totalSuppliers.toString(),
                      icon: Icons.local_shipping,
                      color: Colors.indigo,
                    ),
                    StatCard(
                      title: l10n.sales,
                      value: stats.totalSales.toString(),
                      icon: Icons.shopping_cart,
                      color: Colors.green,
                    ),
                    StatCard(
                      title: l10n.revenue,
                      value:
                          "${stats.totalRevenue.toStringAsFixed(2)} DA",
                      icon: Icons.payments,
                      color: Colors.teal,
                    ),
                    StatCard(
                      title: l10n.lowStock,
                      value: stats.lowStockProducts.toString(),
                      icon: Icons.warning_amber_rounded,
                      color: Colors.red,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}