import 'package:flutter/material.dart';

import '../../../products/domain/entities/product.dart';

class ProductSelectorTile extends StatelessWidget {
  final Product product;
  final VoidCallback onAdd;

  const ProductSelectorTile({
    super.key,
    required this.product,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        vertical: 6,
      ),
      child: ListTile(
        leading: const CircleAvatar(
          child: Icon(Icons.inventory_2_outlined),
        ),
        title: Text(
          product.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          'Stock: ${product.quantity}',
        ),
        trailing: FilledButton.icon(
          onPressed: product.quantity > 0 ? onAdd : null,
          icon: const Icon(Icons.add),
          label: const Text("Add"),
        ),
      ),
    );
  }
}