import 'package:flutter/material.dart';

import '../../domain/entities/receipt_item.dart';

class ReceiptItemTile extends StatelessWidget {
  final ReceiptItem item;

  const ReceiptItemTile({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    item.productName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                Expanded(
                  child: Text(
                    "${item.quantity} × ${item.price.toStringAsFixed(2)} DA",
                    style: TextStyle(
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),

                Text(
                  "${item.subtotal.toStringAsFixed(2)} DA",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}