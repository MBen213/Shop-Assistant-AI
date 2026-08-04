import 'package:flutter/material.dart';

import '../../domain/entities/purchase_item.dart';

class PurchaseItemTile extends StatelessWidget {
  final PurchaseItem item;
  final VoidCallback? onDelete;

  const PurchaseItemTile({
    super.key,
    required this.item,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        vertical: 6,
      ),
      child: ListTile(
        leading: const Icon(Icons.shopping_bag),
        title: Text(item.productName),
        subtitle: Text(
          "${item.quantity} × ${item.purchasePrice.toStringAsFixed(2)} DA",
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "${item.total.toStringAsFixed(2)} DA",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              onPressed: onDelete,
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}