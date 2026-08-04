import 'package:flutter/material.dart';

Future<bool> showDeleteProductDialog(
  BuildContext context,
) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (_) {
      return AlertDialog(
        title: const Text('Delete Product'),
        content: const Text(
          'Are you sure you want to delete this product?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      );
    },
  );

  return result ?? false;
}