import 'package:flutter/material.dart';

import '../../domain/entities/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const ProductCard({
    super.key,
    required this.product,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        onTap: onEdit,
        leading: const CircleAvatar(
          child: Icon(Icons.inventory_2),
        ),
        title: Text(product.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Barcode : ${product.barcode}"),
            Text("Quantity : ${product.quantity}"),
            Text("Purchase : \$${product.purchasePrice}"),
            Text("Selling : \$${product.sellingPrice}"),
            Text("Profit : \$${product.profit}"),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(
            Icons.delete,
            color: Colors.red,
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                  title: const Text("Delete Product"),
                  content: Text(
                    'Are you sure you want to delete "${product.name}"?',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Cancel"),
                    ),
                    FilledButton(
                      onPressed: () {
                        Navigator.pop(context);
                        onDelete();
                      },
                      child: const Text("Delete"),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}