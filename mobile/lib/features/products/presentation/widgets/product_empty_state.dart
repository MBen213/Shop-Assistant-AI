import 'package:flutter/material.dart';

class ProductEmptyState extends StatelessWidget {
  const ProductEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'No products found',
        style: TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }
}