import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/reports_provider.dart';
import '../widgets/statistics_card.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ReportsProvider()..loadStatistics(),
      child: const _ReportsView(),
    );
  }
}

class _ReportsView extends StatelessWidget {
  const _ReportsView();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ReportsProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Reports"),
      ),
      body: provider.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : provider.statistics == null
              ? const Center(
                  child: Text("No Data"),
                )
              : RefreshIndicator(
                  onRefresh: provider.refresh,
                  child: GridView.count(
                    padding: const EdgeInsets.all(16),
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    children: [
                      StatisticsCard(
                        title: "Today's Sales",
                        value:
                            "\$${provider.statistics!.todaySales.toStringAsFixed(2)}",
                        icon: Icons.attach_money,
                        color: Colors.green,
                      ),
                      StatisticsCard(
                        title: "Today's Profit",
                        value:
                            "\$${provider.statistics!.todayProfit.toStringAsFixed(2)}",
                        icon: Icons.trending_up,
                        color: Colors.blue,
                      ),
                      StatisticsCard(
                        title: "Products",
                        value:
                            provider.statistics!.totalProducts.toString(),
                        icon: Icons.inventory_2,
                        color: Colors.orange,
                      ),
                      StatisticsCard(
                        title: "Customers",
                        value:
                            provider.statistics!.totalCustomers.toString(),
                        icon: Icons.people,
                        color: Colors.purple,
                      ),
                      StatisticsCard(
                        title: "Low Stock",
                        value:
                            provider.statistics!.lowStockProducts.toString(),
                        icon: Icons.warning_amber_rounded,
                        color: Colors.red,
                      ),
                    ],
                  ),
                ),
    );
  }
}