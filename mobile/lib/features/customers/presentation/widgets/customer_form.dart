import 'package:flutter/material.dart';

import '../../domain/entities/customer.dart';

class CustomerForm extends StatefulWidget {
  final Customer? customer;
  final Function(
    String name,
    String phone,
    String? address,
    String? notes,
  ) onSave;

  const CustomerForm({
    super.key,
    this.customer,
    required this.onSave,
  });

  @override
  State<CustomerForm> createState() => _CustomerFormState();
}

class _CustomerFormState extends State<CustomerForm> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _addressController;
  late final TextEditingController _notesController;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController(
      text: widget.customer?.name ?? '',
    );

    _phoneController = TextEditingController(
      text: widget.customer?.phone ?? '',
    );

    _addressController = TextEditingController(
      text: widget.customer?.address ?? '',
    );

    _notesController = TextEditingController(
      text: widget.customer?.notes ?? '',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    widget.onSave(
      _nameController.text.trim(),
      _phoneController.text.trim(),
      _addressController.text.trim().isEmpty
          ? null
          : _addressController.text.trim(),
      _notesController.text.trim().isEmpty
          ? null
          : _notesController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: "Customer Name",
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Enter customer name";
                }
                return null;
              },
            ),

            const SizedBox(height: 12),

            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: "Phone",
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Enter phone number";
                }
                return null;
              },
            ),

            const SizedBox(height: 12),

            TextFormField(
              controller: _addressController,
              decoration: const InputDecoration(
                labelText: "Address (Optional)",
              ),
            ),

            const SizedBox(height: 12),

            TextFormField(
              controller: _notesController,
              decoration: const InputDecoration(
                labelText: "Notes (Optional)",
              ),
              maxLines: 3,
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _submit,
                child: Text(
                  widget.customer == null
                      ? "Add Customer"
                      : "Update Customer",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}