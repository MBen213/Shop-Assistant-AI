import 'package:flutter/material.dart';

import '../providers/products_provider.dart';
import 'product_form.dart';

class AddProductFab extends StatelessWidget {
  final ProductsProvider provider;

  const AddProductFab({
    super.key,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
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
    );
  }
}