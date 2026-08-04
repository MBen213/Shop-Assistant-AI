import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/purchases_provider.dart';
import '../widgets/purchase_card.dart';
import '../widgets/purchase_dialog.dart';

class PurchasesPage extends StatelessWidget {
  const PurchasesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PurchasesProvider(),
      child: const _PurchasesView(),
    );
  }
}

class _PurchasesView extends StatelessWidget {
  const _PurchasesView();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PurchasesProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Purchases"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => const PurchaseDialog(),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: provider.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Card(
                  margin: const EdgeInsets.all(16),
                  child: ListTile(
                    leading: const Icon(Icons.shopping_cart),
                    title: Text(
                      "Purchases: ${provider.purchasesCount}",
                    ),
                    subtitle: Text(
                      "Total: ${provider.totalPurchases.toStringAsFixed(2)}",
                    ),
                  ),
                ),
                Expanded(
                  child: provider.purchases.isEmpty
                      ? const Center(
                          child: Text(
                            "No Purchases Yet",
                          ),
                        )
                      : ListView.builder(
                          itemCount: provider.purchases.length,
                          itemBuilder: (_, index) {
                            return PurchaseCard(
                              purchase: provider.purchases[index],
                            );
                          },
                        ),
                ),
              ],
            ),
    );
  }
}