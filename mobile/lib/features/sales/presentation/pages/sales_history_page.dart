import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/sales_provider.dart';
import '../widgets/sale_card.dart';
import '../widgets/sale_details_dialog.dart';

class SalesHistoryPage extends StatefulWidget {
  const SalesHistoryPage({super.key});

  @override
  State<SalesHistoryPage> createState() => _SalesHistoryPageState();
}

class _SalesHistoryPageState extends State<SalesHistoryPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      context.read<SalesProvider>().loadSales();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SalesProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Sales History"),
      ),
      body: provider.isHistoryLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : provider.sales.isEmpty
              ? const Center(
                  child: Text(
                    "No Sales Found",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: provider.sales.length,
                  itemBuilder: (context, index) {
                    final sale = provider.sales[index];

                    return SaleCard(
                      sale: sale,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (_) => SaleDetailsDialog(
                            sale: sale,
                          ),
                        );
                      },
                    );
                  },
                ),
    );
  }
}