import 'package:flutter/material.dart';

import '../../domain/entities/purchase.dart';

class PurchaseCard extends StatelessWidget {
  final Purchase purchase;

  const PurchaseCard({
    super.key,
    required this.purchase,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: ListTile(
        leading: const CircleAvatar(
          child: Icon(Icons.shopping_cart),
        ),
        title: Text(
          purchase.supplierName,
        ),
        subtitle: Text(
         "${purchase.date.day.toString().padLeft(2, '0')}/"
         "${purchase.date.month.toString().padLeft(2, '0')}/"
         "${purchase.date.year} "
         "${purchase.date.hour.toString().padLeft(2, '0')}:"
         "${purchase.date.minute.toString().padLeft(2, '0')}",
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${purchase.total.toStringAsFixed(2)} DA",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "${purchase.items.length} items",
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}