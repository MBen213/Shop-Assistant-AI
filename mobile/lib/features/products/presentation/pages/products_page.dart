import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';
import '../widgets/product_card.dart';
import '../widgets/product_form.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductsProvider()..loadProducts(),
      child: const _ProductsView(),
    );
  }
}

class _ProductsView extends StatelessWidget {
  const _ProductsView();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProductsProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
      ),
      body: provider.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: "Search product...",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: provider.search,
                  ),
                ),

                Expanded(
                  child: provider.filteredProducts.isEmpty
                      ? const Center(
                          child: Text(
                            "No products found",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: provider.filteredProducts.length,
                          itemBuilder: (context, index) {
                            final product =
                                provider.filteredProducts[index];

                            return ProductCard(
                              product: product,

                              onEdit: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (_) {
                                    return ProductForm(
                                      product: product,
                                      onSave: ({
                                        required String name,
                                        required String barcode,
                                        required double purchasePrice,
                                        required double sellingPrice,
                                        required int quantity,
                                      }) async {
                                        await provider.updateProduct(
                                          product.copyWith(
                                            name: name,
                                            barcode: barcode,
                                            purchasePrice: purchasePrice,
                                            sellingPrice: sellingPrice,
                                            quantity: quantity,
                                          ),
                                        );

                                        if (context.mounted) {
                                          Navigator.pop(context);
                                        }
                                      },
                                    );
                                  },
                                );
                              },

                              onDelete: () async {
                                final confirm = await showDialog<bool>(
                                  context: context,
                                  builder: (_) {
                                    return AlertDialog(
                                      title: const Text("Delete Product"),
                                      content: const Text(
                                        "Are you sure you want to delete this product?",
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context, false);
                                          },
                                          child: const Text("Cancel"),
                                        ),
                                        FilledButton(
                                          onPressed: () {
                                            Navigator.pop(context, true);
                                          },
                                          child: const Text("Delete"),
                                        ),
                                      ],
                                    );
                                  },
                                );

                                if (confirm == true) {
                                  await provider.deleteProduct(product.id);
                                }
                              },
                            );
                          },
                        ),
                ),
              ],
            ),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (_) {
              return ProductForm(
                onSave: ({
                  required String name,
                  required String barcode,
                  required double purchasePrice,
                  required double sellingPrice,
                  required int quantity,
                }) async {
                  await provider.addProduct(
                    name: name,
                    barcode: barcode,
                    purchasePrice: purchasePrice,
                    sellingPrice: sellingPrice,
                    quantity: quantity,
                  );

                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}