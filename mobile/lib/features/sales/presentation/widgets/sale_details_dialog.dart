import 'package:flutter/material.dart';

import '../../domain/entities/sale.dart';

class SaleDetailsDialog extends StatelessWidget {
  final Sale sale;

  const SaleDetailsDialog({
    super.key,
    required this.sale,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Invoice Details",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      content: SizedBox(
        width: 450,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Icon(Icons.receipt_long),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    "Invoice #${sale.id.substring(0, 8)}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                sale.createdAt.toString().substring(0, 19),
              ),
            ),

            const Divider(height: 24),

            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: sale.items.length,
                itemBuilder: (context, index) {
                  final item = sale.items[index];

                  return ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    title: Text(item.productName),
                    subtitle: Text(
                      "${item.quantity} × ${item.price.toStringAsFixed(2)} DA",
                    ),
                    trailing: Text(
                      "${item.subtotal.toStringAsFixed(2)} DA",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
            ),

            const Divider(),

            Row(
              children: [
                const Expanded(
                  child: Text(
                    "TOTAL",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                Text(
                  "${sale.total.toStringAsFixed(2)} DA",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        FilledButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Close"),
        ),
      ],
    );
  }
}