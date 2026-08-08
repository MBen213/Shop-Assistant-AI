import 'package:flutter/material.dart';

import '../../domain/entities/customer.dart';

class CustomerCard extends StatelessWidget {
  final Customer customer;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const CustomerCard({
    super.key,
    required this.customer,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 6,
      ),
      child: ListTile(
        leading: const CircleAvatar(
          child: Icon(Icons.person),
        ),

        title: Text(
          customer.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              customer.phone,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

            if (customer.address != null &&
                customer.address!.isNotEmpty)
              Text(
                customer.address!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

            const SizedBox(height: 4),

            Text(
              "Debt: ${customer.debt.toStringAsFixed(2)} DA",
              style: TextStyle(
                color:
                    customer.debt > 0 ? Colors.red : Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),

        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              visualDensity: VisualDensity.compact,
              constraints: const BoxConstraints(),
              icon: const Icon(Icons.edit),
              onPressed: onEdit,
            ),

            const SizedBox(width: 8),

            IconButton(
              visualDensity: VisualDensity.compact,
              constraints: const BoxConstraints(),
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}