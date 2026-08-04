import 'package:flutter/material.dart';

import '../../domain/entities/product.dart';
import 'product_card.dart';

class ProductsList extends StatelessWidget {
  final List<Product> products;
  final Future<void> Function(Product product) onEdit;
  final Future<void> Function(Product product) onDelete;

  const ProductsList({
    super.key,
    required this.products,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];

        return ProductCard(
          product: product,
          onEdit: () => onEdit(product),
          onDelete: () => onDelete(product),
        );
      },
    );
  }
}