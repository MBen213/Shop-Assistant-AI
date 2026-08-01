import 'package:flutter/material.dart';

import '../../domain/entities/sale_item.dart';

class CartItemTile extends StatelessWidget {
  final SaleItem item;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;
  final VoidCallback onRemove;

  const CartItemTile({
    super.key,
    required this.item,
    required this.onIncrease,
    required this.onDecrease,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        title: Text(
          item.productName,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          "${item.price.toStringAsFixed(2)} DA × ${item.quantity}",
        ),
        trailing: SizedBox(
          width: 170,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: onDecrease,
                icon: const Icon(Icons.remove_circle_outline),
              ),

              Text(
                item.quantity.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              IconButton(
                onPressed: onIncrease,
                icon: const Icon(Icons.add_circle_outline),
              ),

              const SizedBox(width: 8),

              Text(
                "${item.subtotal.toStringAsFixed(2)} DA",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              IconButton(
                onPressed: onRemove,
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}