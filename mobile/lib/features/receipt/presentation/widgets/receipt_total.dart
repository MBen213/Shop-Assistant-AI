import 'package:flutter/material.dart';

class ReceiptTotal extends StatelessWidget {
  final double total;

  const ReceiptTotal({
    super.key,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            const Icon(
              Icons.payments,
              color: Colors.green,
              size: 30,
            ),

            const SizedBox(width: 14),

            const Expanded(
              child: Text(
                "Grand Total",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            Text(
              "${total.toStringAsFixed(2)} DA",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}