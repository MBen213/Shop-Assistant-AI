import 'package:flutter/material.dart';

class PurchaseSummary extends StatelessWidget {
  final double total;

  const PurchaseSummary({
    super.key,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.green.shade50,
      margin: const EdgeInsets.only(top: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const Expanded(
              child: Text(
                "Total Purchase",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            Text(
              "${total.toStringAsFixed(2)} DA",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}