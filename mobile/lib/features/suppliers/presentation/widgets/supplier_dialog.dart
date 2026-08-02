import 'package:flutter/material.dart';

import '../../domain/entities/supplier.dart';

class SupplierDialog extends StatefulWidget {
  final Supplier? supplier;

  const SupplierDialog({
    super.key,
    this.supplier,
  });

  @override
  State<SupplierDialog> createState() => _SupplierDialogState();
}

class _SupplierDialogState extends State<SupplierDialog> {
  late final TextEditingController nameController;
  late final TextEditingController phoneController;
  late final TextEditingController addressController;
  late final TextEditingController emailController;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(
      text: widget.supplier?.name ?? '',
    );

    phoneController = TextEditingController(
      text: widget.supplier?.phone ?? '',
    );

    addressController = TextEditingController(
      text: widget.supplier?.address ?? '',
    );

    emailController = TextEditingController(
      text: widget.supplier?.email ?? '',
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.supplier == null
            ? "Add Supplier"
            : "Edit Supplier",
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Supplier Name",
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: "Phone",
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: addressController,
              decoration: const InputDecoration(
                labelText: "Address",
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: "Email",
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            if (nameController.text.trim().isEmpty) {
              return;
            }

            Navigator.pop(
              context,
              {
                "name": nameController.text.trim(),
                "phone": phoneController.text.trim(),
                "address": addressController.text.trim(),
                "email": emailController.text.trim(),
              },
            );
          },
          child: const Text("Save"),
        ),
      ],
    );
  }
}