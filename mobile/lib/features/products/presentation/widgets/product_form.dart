import 'package:flutter/material.dart';

import '../../domain/entities/product.dart';

class ProductForm extends StatefulWidget {
  final Future<void> Function({
    required String name,
    required String barcode,
    required double purchasePrice,
    required double sellingPrice,
    required int quantity,
  }) onSave;

  final Product? product;

  const ProductForm({
    super.key,
    this.product,
    required this.onSave,
  });

  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _barcodeController = TextEditingController();
  final _purchaseController = TextEditingController();
  final _sellingController = TextEditingController();
  final _quantityController = TextEditingController();

  bool _isSaving = false;

  bool get _isEditing => widget.product != null;

  String get _title => _isEditing ? 'Edit Product' : 'Add Product';

  String get _buttonText =>
      _isEditing ? 'Update Product' : 'Add Product';

  @override
  void initState() {
    super.initState();

    final product = widget.product;

    if (product != null) {
      _nameController.text = product.name;
      _barcodeController.text = product.barcode;
      _purchaseController.text = product.purchasePrice.toString();
      _sellingController.text = product.sellingPrice.toString();
      _quantityController.text = product.quantity.toString();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _barcodeController.dispose();
    _purchaseController.dispose();
    _sellingController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: const OutlineInputBorder(),
    );
  }

  String? _requiredValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Required';
    }
    return null;
  }

  String? _doubleValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Required';
    }

    if (double.tryParse(value) == null) {
      return 'Invalid number';
    }

    return null;
  }

  String? _intValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Required';
    }

    if (int.tryParse(value) == null) {
      return 'Invalid number';
    }

    return null;
  }

  Future<void> _save() async {
    if (_isSaving) return;

    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSaving = true;
    });

    try {
      await widget.onSave(
        name: _nameController.text.trim(),
        barcode: _barcodeController.text.trim(),
        purchasePrice: double.parse(_purchaseController.text.trim()),
        sellingPrice: double.parse(_sellingController.text.trim()),
        quantity: int.parse(_quantityController.text.trim()),
      );

      if (!mounted) return;

      Navigator.pop(context);
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        16,
        16,
        16,
        bottomInset + 16,
      ),
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              TextFormField(
                controller: _nameController,
                decoration: _inputDecoration('Product Name'),
                validator: _requiredValidator,
                textInputAction: TextInputAction.next,
              ),

              const SizedBox(height: 12),

              TextFormField(
                controller: _barcodeController,
                decoration: _inputDecoration('Barcode'),
                textInputAction: TextInputAction.next,
              ),

              const SizedBox(height: 12),

              TextFormField(
                controller: _purchaseController,
                decoration: _inputDecoration('Purchase Price'),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                validator: _doubleValidator,
                textInputAction: TextInputAction.next,
              ),

              const SizedBox(height: 12),

              TextFormField(
                controller: _sellingController,
                decoration: _inputDecoration('Selling Price'),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                validator: _doubleValidator,
                textInputAction: TextInputAction.next,
              ),

              const SizedBox(height: 12),

              TextFormField(
                controller: _quantityController,
                decoration: _inputDecoration('Quantity'),
                keyboardType: TextInputType.number,
                validator: _intValidator,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) => _save(),
              ),

              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: FilledButton(
                  onPressed: _isSaving ? null : _save,
                  child: _isSaving
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Text(_buttonText),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}