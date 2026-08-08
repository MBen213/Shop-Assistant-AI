import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/sales_provider.dart';

import '../widgets/cart_item_tile.dart';
import '../widgets/cart_total.dart';
import '../widgets/complete_sale_button.dart';
import '../widgets/product_selector_tile.dart';
import '../widgets/checkout/checkout_bottom_sheet.dart';

import 'sales_history_page.dart';

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
        centerTitle: true,
        title: const Text("Sales"),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            tooltip: "Sales History",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SalesHistoryPage(),
                ),
              );
            },
          ),
        ],
      ),

      body: provider.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                // ====================================================
                // SEARCH
                // ====================================================

                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    16,
                    16,
                    16,
                    8,
                  ),
                  child: TextField(
                    onChanged: provider.searchProducts,
                    decoration: InputDecoration(
                      hintText: "Search product...",
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: provider.searchQuery.isEmpty
                          ? null
                          : IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: provider.clearSearch,
                            ),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ),

                // ====================================================
                // PRODUCTS HEADER
                // ====================================================

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: Row(
                    children: [
                      Text(
                        "Products (${provider.products.length})",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Chip(
                        avatar: const Icon(
                          Icons.shopping_cart,
                          size: 18,
                        ),
                        label: Text(
                          "${provider.cartItemsCount} Items",
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                // ====================================================
                // PRODUCTS LIST
                // ====================================================

                Expanded(
                  flex: 2,
                  child: provider.products.isEmpty
                      ? const Center(
                          child: Text(
                            "No products found",
                          ),
                        )
                      : ListView.builder(
                          itemCount: provider.products.length,
                          itemBuilder: (context, index) {
                            final product =
                                provider.products[index];

                            return ProductSelectorTile(
                              product: product,
                              onAdd: () {
                                provider.addToCart(product);
                              },
                            );
                          },
                        ),
                ),

                const Divider(),

                // ====================================================
                // CART HEADER
                // ====================================================

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: Row(
                    children: [
                      Text(
                        "Cart (${provider.cartItemsCount})",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      if (provider.cart.isNotEmpty)
                        TextButton.icon(
                          onPressed: provider.clearCart,
                          icon: const Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                          ),
                          label: const Text(
                            "Clear",
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                // ====================================================
                // CART LIST
                // ====================================================

                Expanded(
                  flex: 2,
                  child: provider.cart.isEmpty
                      ? const Center(
                          child: Text(
                            "Cart is empty",
                          ),
                        )
                      : ListView.builder(
                          itemCount: provider.cart.length,
                          itemBuilder: (context, index) {
                            final item =
                                provider.cart[index];

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

                // ====================================================
                // TOTAL
                // ====================================================

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: CartTotal(
                    total: provider.total,
                  ),
                ),

                const SizedBox(height: 12),

                // ====================================================
                // COMPLETE SALE
                // ====================================================

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: CompleteSaleButton(
                    enabled: provider.cart.isNotEmpty,
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        useSafeArea: true,
                        shape:
                            const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(
                            top: Radius.circular(24),
                          ),
                        ),
                        builder: (_) =>
                            CheckoutBottomSheet(
                          total: provider.total,
                          onConfirm: () async {
                            try {
                              final sale =
                                  await provider.completeSale();

                              if (!context.mounted) {
                                return;
                              }

                              if (sale == null) {
                                return;
                              }

                              Navigator.pop(context);

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Sale completed successfully",
                                  ),
                                ),
                              );
                            } catch (e) {
                              if (!context.mounted) {
                                return;
                              }

                              Navigator.pop(context);

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Failed to complete sale: $e",
                                  ),
                                ),
                              );
                            }
                          },
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