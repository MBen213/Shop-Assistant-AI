import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';

import '../widgets/product_form.dart';
import '../widgets/product_search_bar.dart';
import '../widgets/product_empty_state.dart';
import '../widgets/products_list.dart';
import '../widgets/loading_view.dart';
import '../widgets/delete_product_dialog.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _ProductsView();
  }
}

class _ProductsView extends StatelessWidget {
  const _ProductsView();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProductsProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: provider.isLoading
          ? const LoadingView()
          : Column(
              children: [
                ProductSearchBar(
                  onChanged: provider.search,
                ),
                Expanded(
                  child: provider.filteredProducts.isEmpty
                      ? const ProductEmptyState()
                      : ProductsList(
                          products: provider.filteredProducts,
                          onEdit: (product) async {
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
                          onDelete: (product) async {
                            final confirm =
                                await showDeleteProductDialog(context);

                            if (confirm) {
                              await provider.deleteProduct(product.id);
                            }
                          },
                        ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
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
        child: const Icon(Icons.add),
      ),
    );
  }
}