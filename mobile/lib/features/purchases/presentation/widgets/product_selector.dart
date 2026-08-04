import 'package:flutter/material.dart';

class ProductSelector extends StatelessWidget {
  final VoidCallback? onTap;

  const ProductSelector({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.inventory_2),
        title: const Text("Select Product"),
        subtitle: const Text(
          "Tap to choose a product",
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
        ),
        onTap: onTap,
      ),
    );
  }
}