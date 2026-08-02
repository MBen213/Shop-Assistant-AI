import 'package:flutter/material.dart';

import '../../domain/entities/customer.dart';
import 'customer_form.dart';

class CustomerDialog extends StatelessWidget {
  final Customer? customer;

  final Future<void> Function(
    String name,
    String phone,
    String? address,
    String? notes,
  ) onSave;

  const CustomerDialog({
    super.key,
    this.customer,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        customer == null
            ? 'Add Customer'
            : 'Edit Customer',
      ),
      content: SizedBox(
        width: 450,
        child: CustomerForm(
          customer: customer,
          onSave: (
            name,
            phone,
            address,
            notes,
          ) async {
            await onSave(
              name,
              phone,
              address,
              notes,
            );

            if (context.mounted) {
              Navigator.pop(context);
            }
          },
        ),
      ),
    );
  }
}