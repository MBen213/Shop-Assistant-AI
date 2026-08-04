import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../suppliers/presentation/providers/suppliers_provider.dart';

import '../../domain/entities/purchase_item.dart';

import 'product_selector.dart';
import 'purchase_item_tile.dart';
import 'purchase_summary.dart';

class PurchaseDialog extends StatefulWidget {
  const PurchaseDialog({super.key});

  @override
  State<PurchaseDialog> createState() =>
      _PurchaseDialogState();
}

class _PurchaseDialogState
    extends State<PurchaseDialog> {
  String? supplierId;
  String? supplierName;

  final List<PurchaseItem> items = [];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SuppliersProvider(),
      child: Consumer<SuppliersProvider>(
        builder: (context, supplierProvider, _) {
          return AlertDialog(
            title: const Text(
              "New Purchase",
            ),
            content: SizedBox(
              width: 650,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment:
                      CrossAxisAlignment.stretch,
                  children: [
                    DropdownButtonFormField<String>(
                      initialValue: supplierId,
                      decoration: const InputDecoration(
                        labelText: "Supplier",
                        border: OutlineInputBorder(),
                      ),
                      items: supplierProvider.suppliers
                          .map(
                            (supplier) =>
                                DropdownMenuItem<String>(
                              value: supplier.id,
                              child: Text(
                                supplier.name,
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value == null) return;

                        final supplier =
                            supplierProvider.suppliers
                                .firstWhere(
                          (e) => e.id == value,
                        );

                        setState(() {
                          supplierId = supplier.id;
                          supplierName =
                              supplier.name;
                        });
                      },
                    ),

                    const SizedBox(height: 20),

                    ProductSelector(
                      onTap: () {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Product selector will be implemented next.",
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 16),

                    if (items.isEmpty)
                      const Center(
                        child: Padding(
                          padding:
                              EdgeInsets.all(16),
                          child: Text(
                            "No products added.",
                          ),
                        ),
                      ),

                    ...items.map(
                      (item) => PurchaseItemTile(
                        item: item,
                        onDelete: () {
                          setState(() {
                            items.remove(item);
                          });
                        },
                      ),
                    ),

                    const SizedBox(height: 16),

                    PurchaseSummary(
                      total: items.fold(
                        0,
                        (sum, item) =>
                            sum + item.total,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel"),
              ),
              FilledButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Save will be implemented next.",
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.save),
                label: const Text("Save"),
              ),
            ],
          );
        },
      ),
    );
  }
}