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

  final nameController = TextEditingController();
  final barcodeController = TextEditingController();
  final purchaseController = TextEditingController();
  final sellingController = TextEditingController();
  final quantityController = TextEditingController();

  bool isSaving = false;

  @override
  void initState() {
    super.initState();

    if (widget.product != null) {
      nameController.text = widget.product!.name;
      barcodeController.text = widget.product!.barcode;
      purchaseController.text =
          widget.product!.purchasePrice.toString();
      sellingController.text =
          widget.product!.sellingPrice.toString();
      quantityController.text =
          widget.product!.quantity.toString();
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    barcodeController.dispose();
    purchaseController.dispose();
    sellingController.dispose();
    quantityController.dispose();
    super.dispose();
  }

  Future<void> save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      isSaving = true;
    });

    await widget.onSave(
      name: nameController.text.trim(),
      barcode: barcodeController.text.trim(),
      purchasePrice: double.parse(purchaseController.text),
      sellingPrice: double.parse(sellingController.text),
      quantity: int.parse(quantityController.text),
    );

    if (!mounted) return;

    setState(() {
      isSaving = false;
    });

    Navigator.pop(context); // إغلاق النافذة بعد نجاح الحفظ
  }

  InputDecoration input(String label) {
    return InputDecoration(
      labelText: label,
      border: const OutlineInputBorder(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.product == null
                    ? "Add Product"
                    : "Edit Product",
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              TextFormField(
                controller: nameController,
                decoration: input("Product Name"),
                validator: (v) =>
                    v == null || v.isEmpty ? "Required" : null,
              ),

              const SizedBox(height: 12),

              TextFormField(
                controller: barcodeController,
                decoration: input("Barcode"),
              ),

              const SizedBox(height: 12),

              TextFormField(
                controller: purchaseController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: input("Purchase Price"),
                validator: (v) {
                  if (v == null || v.isEmpty) return "Required";
                  if (double.tryParse(v) == null) return "Invalid number";
                  return null;
                },
              ),

              const SizedBox(height: 12),

              TextFormField(
                controller: sellingController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: input("Selling Price"),
                validator: (v) {
                  if (v == null || v.isEmpty) return "Required";
                  if (double.tryParse(v) == null) return "Invalid number";
                  return null;
                },
              ),

              const SizedBox(height: 12),

              TextFormField(
                controller: quantityController,
                keyboardType: TextInputType.number,
                decoration: input("Quantity"),
                validator: (v) {
                  if (v == null || v.isEmpty) return "Required";
                  if (int.tryParse(v) == null) return "Invalid number";
                  return null;
                },
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: isSaving ? null : save,
                  child: isSaving
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          widget.product == null
                              ? "Add Product"
                              : "Update Product",
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}