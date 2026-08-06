import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/receipt_provider.dart';

import '../widgets/receipt_actions.dart';
import '../widgets/receipt_header.dart';
import '../widgets/receipt_item_tile.dart';
import '../widgets/receipt_total.dart';

class ReceiptPage extends StatelessWidget {
  final String saleId;

  const ReceiptPage({
    super.key,
    required this.saleId,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ReceiptProvider()..loadReceipt(saleId),
      child: const _ReceiptView(),
    );
  }
}

class _ReceiptView extends StatelessWidget {
  const _ReceiptView();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ReceiptProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Receipt"),
        centerTitle: true,
      ),
      body: provider.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : provider.receipt == null
              ? const Center(
                  child: Text(
                    "Receipt not found",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                )
              : ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    ReceiptHeader(
                      receipt: provider.receipt!,
                    ),

                    const SizedBox(height: 20),

                    ...provider.receipt!.items.map(
                      (item) => ReceiptItemTile(
                        item: item,
                      ),
                    ),

                    const SizedBox(height: 20),

                    ReceiptTotal(
                      total: provider.receipt!.total,
                    ),

                    const SizedBox(height: 30),

                    ReceiptActions(
                      receipt: provider.receipt!,
                    ),

                    const SizedBox(height: 30),
                  ],
                ),
    );
  }
}