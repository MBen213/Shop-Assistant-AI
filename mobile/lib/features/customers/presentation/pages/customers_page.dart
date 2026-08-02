import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/customer.dart';
import '../providers/customers_provider.dart';
import '../widgets/customer_card.dart';
import '../widgets/customer_dialog.dart';
import '../widgets/customer_search_bar.dart';

class CustomersPage extends StatelessWidget {
  const CustomersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CustomersProvider()..loadCustomers(),
      child: const _CustomersView(),
    );
  }
}

class _CustomersView extends StatelessWidget {
  const _CustomersView();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CustomersProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Customers"),
      ),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) {
              return CustomerDialog(
                onSave: (
                  name,
                  phone,
                  address,
                  notes,
                ) async {
                  await provider.addCustomer(
                    name: name,
                    phone: phone,
                    address: address,
                    notes: notes,
                  );
                },
              );
            },
          );
        },
      ),

      body: provider.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                CustomerSearchBar(
                  onChanged: provider.search,
                ),

                Expanded(
                  child: provider.filteredCustomers.isEmpty
                      ? const Center(
                          child: Text(
                            "No Customers Found",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount:
                              provider.filteredCustomers.length,
                          itemBuilder: (context, index) {
                            final Customer customer =
                                provider.filteredCustomers[index];

                            return CustomerCard(
                              customer: customer,

                              onEdit: () {
                                showDialog(
                                  context: context,
                                  builder: (_) {
                                    return CustomerDialog(
                                      customer: customer,
                                      onSave: (
                                        name,
                                        phone,
                                        address,
                                        notes,
                                      ) async {
                                        await provider.updateCustomer(
                                          customer.copyWith(
                                            name: name,
                                            phone: phone,
                                            address: address,
                                            notes: notes,
                                          ),
                                        );
                                      },
                                    );
                                  },
                                );
                              },

                              onDelete: () async {
                                final result =
                                    await showDialog<bool>(
                                  context: context,
                                  builder: (_) {
                                    return AlertDialog(
                                      title: const Text(
                                        "Delete Customer",
                                      ),
                                      content: Text(
                                        "Delete ${customer.name} ?",
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(
                                                context,
                                                false);
                                          },
                                          child:
                                              const Text("Cancel"),
                                        ),
                                        FilledButton(
                                          onPressed: () {
                                            Navigator.pop(
                                                context,
                                                true);
                                          },
                                          child:
                                              const Text("Delete"),
                                        ),
                                      ],
                                    );
                                  },
                                );

                                if (result == true) {
                                  await provider.deleteCustomer(
                                    customer.id,
                                  );
                                }
                              },
                            );
                          },
                        ),
                ),
              ],
            ),
    );
  }
}