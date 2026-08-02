import 'package:flutter/material.dart';

import '../../domain/entities/supplier.dart';

class SupplierCard extends StatelessWidget {
  final Supplier supplier;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const SupplierCard({
    super.key,
    required this.supplier,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: ListTile(
        leading: const CircleAvatar(
          child: Icon(Icons.local_shipping),
        ),
        title: Text(
          supplier.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(supplier.phone),
            if (supplier.address.isNotEmpty)
              Text(supplier.address),
            if (supplier.email.isNotEmpty)
              Text(supplier.email),
          ],
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            if (value == "edit") {
              onEdit();
            } else {
              onDelete();
            }
          },
          itemBuilder: (_) => const [
            PopupMenuItem(
              value: "edit",
              child: Text("Edit"),
            ),
            PopupMenuItem(
              value: "delete",
              child: Text("Delete"),
            ),
          ],
        ),
      ),
    );
  }
}