import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/supplier.dart';
import '../providers/suppliers_provider.dart';
import '../widgets/supplier_card.dart';
import '../widgets/supplier_dialog.dart';
import '../widgets/supplier_search_bar.dart';

class SuppliersPage extends StatefulWidget {
  const SuppliersPage({super.key});

  @override
  State<SuppliersPage> createState() => _SuppliersPageState();
}

class _SuppliersPageState extends State<SuppliersPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      context.read<SuppliersProvider>().loadSuppliers();
    });
  }

  Future<void> _addSupplier() async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (_) => const SupplierDialog(),
    );

    if (result == null || !mounted) return;

    await context.read<SuppliersProvider>().addSupplier(
          name: result['name'],
          phone: result['phone'],
          address: result['address'],
          email: result['email'],
        );
  }

  Future<void> _editSupplier(Supplier supplier) async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (_) => SupplierDialog(
        supplier: supplier,
      ),
    );

    if (result == null || !mounted) return;

    await context.read<SuppliersProvider>().updateSupplier(
          supplier.copyWith(
            name: result['name'],
            phone: result['phone'],
            address: result['address'],
            email: result['email'],
          ),
        );
  }

  Future<void> _deleteSupplier(Supplier supplier) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Delete Supplier"),
        content: Text(
          "Are you sure you want to delete ${supplier.name}?",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Delete"),
          ),
        ],
      ),
    );

    if (confirm != true || !mounted) return;

    await context
        .read<SuppliersProvider>()
        .deleteSupplier(supplier.id);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SuppliersProvider>(
      builder: (context, provider, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Suppliers"),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: _addSupplier,
            child: const Icon(Icons.add),
          ),
          body: Column(
            children: [
              SupplierSearchBar(
                onChanged: provider.search,
              ),
              Expanded(
                child: provider.loading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : provider.suppliers.isEmpty
                        ? const Center(
                            child: Text(
                              "No Suppliers Found",
                              style: TextStyle(fontSize: 18),
                            ),
                          )
                        : ListView.builder(
                            itemCount: provider.suppliers.length,
                            itemBuilder: (context, index) {
                              final supplier =
                                  provider.suppliers[index];

                              return SupplierCard(
                                supplier: supplier,
                                onEdit: () =>
                                    _editSupplier(supplier),
                                onDelete: () =>
                                    _deleteSupplier(supplier),
                              );
                            },
                          ),
              ),
            ],
          ),
        );
      },
    );
  }
}