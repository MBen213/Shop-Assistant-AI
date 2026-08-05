import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/sales_provider.dart';
import '../widgets/sale_card.dart';
import '../widgets/sale_details_dialog.dart';

class SalesHistoryPage extends StatefulWidget {
  const SalesHistoryPage({super.key});

  @override
  State<SalesHistoryPage> createState() =>
      _SalesHistoryPageState();
}

class _SalesHistoryPageState
    extends State<SalesHistoryPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      context.read<SalesProvider>().loadSales();
    });
  }

  Future<void> _deleteSale(String id) async {
    final provider = context.read<SalesProvider>();

    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Delete Sale"),
        content: const Text(
          "Are you sure you want to delete this sale?",
        ),
        actions: [
          TextButton(
            onPressed: () =>
                Navigator.pop(context, false),
            child: const Text("Cancel"),
          ),
          FilledButton(
            onPressed: () =>
                Navigator.pop(context, true),
            child: const Text("Delete"),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    await provider.deleteSale(id);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Sale deleted successfully"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SalesProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Sales History"),
        centerTitle: true,
      ),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.point_of_sale),
        onPressed: () => Navigator.pop(context),
      ),

      body: provider.isHistoryLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: provider.refreshHistory,
              child: provider.sales.isEmpty
                  ? ListView(
                      children: const [
                        SizedBox(height: 150),
                        Icon(
                          Icons.receipt_long,
                          size: 80,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: Text(
                            "No Sales Found",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    )
                  : ListView.builder(
                      padding:
                          const EdgeInsets.all(16),
                      itemCount:
                          provider.sales.length,
                      itemBuilder:
                          (context, index) {
                        final sale =
                            provider.sales[index];

                        return Padding(
                          padding:
                              const EdgeInsets.only(
                            bottom: 12,
                          ),
                          child: SaleCard(
                            sale: sale,

                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (_) =>
                                    SaleDetailsDialog(
                                  sale: sale,
                                ),
                              );
                            },

                            onDelete: () =>
                                _deleteSale(
                              sale.id,
                            ),
                          ),
                        );
                      },
                    ),
            ),
    );
  }
}