import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/inventory_provider.dart';
import '../widgets/low_stock_card.dart';
import '../widgets/restock_dialog.dart';

class InventoryPage extends StatelessWidget {
  const InventoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          InventoryProvider()..loadProducts(),
      child: const _InventoryView(),
    );
  }
}

class _InventoryView extends StatelessWidget {
  const _InventoryView();

  @override
  Widget build(BuildContext context) {
    final provider =
        context.watch<InventoryProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Inventory"),
      ),
      body: provider.loading
          ? const Center(
              child:
                  CircularProgressIndicator(),
            )
          : provider.products.isEmpty
              ? const Center(
                  child: Text(
                    "No Low Stock Products",
                  ),
                )
              : ListView.builder(
                  itemCount:
                      provider.products.length,
                  itemBuilder: (context, index) {
                    final product =
                        provider.products[index];

                    return LowStockCard(
                      product: product,
                      onRestock: () async {
                        final qty =
                            await showDialog<int>(
                          context: context,
                          builder: (_) =>
                              const RestockDialog(),
                        );

                        if (qty == null ||
                            qty <= 0) {
                          return;
                        }

                        await provider.restock(
                          product,
                          qty,
                        );

                        if (context.mounted) {
                          ScaffoldMessenger.of(
                                  context)
                              .showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Stock Updated",
                              ),
                            ),
                          );
                        }
                      },
                    );
                  },
                ),
    );
  }
}