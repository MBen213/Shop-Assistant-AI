import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/receipt.dart';

class ReceiptHeader extends StatelessWidget {
  final Receipt receipt;

  const ReceiptHeader({
    super.key,
    required this.receipt,
  });

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat(
      'dd/MM/yyyy HH:mm',
    );

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Icon(
              Icons.storefront,
              size: 54,
              color: Colors.indigo,
            ),

            const SizedBox(height: 12),

            const Text(
              "Shop Assistant AI",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 4),

            Text(
              "Sales Receipt",
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 16,
              ),
            ),

            const Divider(height: 30),

            Row(
              children: [
                const Icon(
                  Icons.receipt_long,
                  size: 18,
                  color: Colors.grey,
                ),

                const SizedBox(width: 8),

                const Text(
                  "Receipt ID",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const Spacer(),

                Flexible(
                  child: Text(
                    receipt.id,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                const Icon(
                  Icons.schedule,
                  size: 18,
                  color: Colors.grey,
                ),

                const SizedBox(width: 8),

                const Text(
                  "Date",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const Spacer(),

                Text(
                  formatter.format(
                    receipt.createdAt,
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