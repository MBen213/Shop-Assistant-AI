import 'package:flutter/material.dart';

import '../../../products/domain/entities/product.dart';

class LowStockCard extends StatelessWidget {
  final Product product;
  final VoidCallback onRestock;

  const LowStockCard({
    super.key,
    required this.product,
    required this.onRestock,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.red.shade100,
          child: const Icon(
            Icons.warning,
            color: Colors.red,
          ),
        ),
        title: Text(product.name),
        subtitle: Text(
          "Stock : ${product.quantity}",
        ),
        trailing: ElevatedButton(
          onPressed: onRestock,
          child: const Text("Restock"),
        ),
      ),
    );
  }
}