import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/sales_provider.dart';
import '../widgets/cart_item_tile.dart';
import '../widgets/cart_total.dart';
import '../widgets/complete_sale_button.dart';
import '../widgets/product_selector_tile.dart';

class SalesPage extends StatelessWidget {
  const SalesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SalesProvider()..loadProductsFromDatabase(),
      child: const _SalesView(),
    );
  }
}

class _SalesView extends StatelessWidget {
  const _SalesView();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SalesProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Sales"),
      ),
      body: provider.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Expanded(
                  flex: 2,
                  child: provider.products.isEmpty
                      ? const Center(
                          child: Text("No products available"),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: provider.products.length,
                          itemBuilder: (context, index) {
                            final product = provider.products[index];

                            return ProductSelectorTile(
                              product: product,
                              onAdd: () {
                                provider.addToCart(product);
                              },
                            );
                          },
                        ),
                ),

                const Divider(height: 1),

                Expanded(
                  flex: 2,
                  child: provider.cart.isEmpty
                      ? const Center(
                          child: Text("Cart is empty"),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: provider.cart.length,
                          itemBuilder: (context, index) {
                            final item = provider.cart[index];

                            return CartItemTile(
                              item: item,
                              onIncrease: () {
                                provider.increaseQuantity(item);
                              },
                              onDecrease: () {
                                provider.decreaseQuantity(item);
                              },
                              onRemove: () {
                                provider.removeItem(item);
                              },
                            );
                          },
                        ),
                ),

                Padding(
                  padding: const EdgeInsets.all(16),
                  child: CartTotal(
                    total: provider.total,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CompleteSaleButton(
                    enabled: provider.cart.isNotEmpty,
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Complete Sale will be implemented next.",
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 16),
              ],
            ),
    );
  }
}