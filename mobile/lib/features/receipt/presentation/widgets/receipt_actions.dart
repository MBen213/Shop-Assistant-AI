import 'package:flutter/material.dart';

import '../../data/services/receipt_export_service.dart';
import '../../data/services/receipt_print_service.dart';
import '../../data/services/receipt_share_service.dart';

import '../../domain/entities/receipt.dart';

class ReceiptActions extends StatelessWidget {
  final Receipt receipt;

  const ReceiptActions({
    super.key,
    required this.receipt,
  });

  @override
  Widget build(BuildContext context) {
    final printService = ReceiptPrintService();
    final exportService = ReceiptExportService();
    final shareService = ReceiptShareService();

    return Column(
      children: [
        //=================================
        // PRINT
        //=================================

        SizedBox(
          width: double.infinity,
          height: 55,
          child: FilledButton.icon(
            icon: const Icon(Icons.print),
            label: const Text(
              "Print Receipt",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            onPressed: () async {
              try {
                await printService.print(receipt);
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "Printing failed\n$e",
                      ),
                    ),
                  );
                }
              }
            },
          ),
        ),

        const SizedBox(height: 12),

        //=================================
        // EXPORT PDF
        //=================================

        SizedBox(
          width: double.infinity,
          height: 55,
          child: OutlinedButton.icon(
            icon: const Icon(Icons.picture_as_pdf),
            label: const Text(
              "Export PDF",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            onPressed: () async {
              try {
                final file =
                    await exportService.export(receipt);

                if (!context.mounted) return;

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    duration: const Duration(seconds: 4),
                    content: Text(
                      "PDF exported successfully\n${file.path}",
                    ),
                  ),
                );
              } catch (e) {
                if (!context.mounted) return;

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Export failed\n$e",
                    ),
                  ),
                );
              }
            },
          ),
        ),

        const SizedBox(height: 12),

        //=================================
        // SHARE
        //=================================

        SizedBox(
          width: double.infinity,
          height: 55,
          child: OutlinedButton.icon(
            icon: const Icon(Icons.share),
            label: const Text(
              "Share Receipt",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            onPressed: () async {
              try {
                await shareService.share(receipt);

                if (!context.mounted) return;

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Receipt shared successfully.",
                    ),
                  ),
                );
              } catch (e) {
                if (!context.mounted) return;

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Share failed\n$e",
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}