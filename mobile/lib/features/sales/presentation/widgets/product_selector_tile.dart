import 'package:flutter/material.dart';

import '../../../products/domain/entities/product.dart';

class ProductSelectorTile extends StatelessWidget {
  final Product product;
  final VoidCallback onAdd;

  const ProductSelectorTile({
    super.key,
    required this.product,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    final bool outOfStock = product.quantity <= 0;
    final bool lowStock =
        product.quantity > 0 && product.quantity <= 5;

    Color stockColor = Colors.green;

    if (outOfStock) {
      stockColor = Colors.red;
    } else if (lowStock) {
      stockColor = Colors.orange;
    }

    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: Colors.indigo.shade50,
              child: Icon(
                Icons.inventory_2_outlined,
                color: Colors.indigo.shade700,
                size: 30,
              ),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    "${product.sellingPrice.toStringAsFixed(2)} DA",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: stockColor.withValues(alpha: .12),
                      borderRadius:
                          BorderRadius.circular(30),
                    ),
                    child: Text(
                      "Stock : ${product.quantity}",
                      style: TextStyle(
                        color: stockColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 12),

            SizedBox(
              height: 45,
              child: FilledButton.icon(
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(14),
                  ),
                ),
                onPressed: outOfStock ? null : onAdd,
                icon: const Icon(Icons.add),
                label: Text(
                  outOfStock ? "Out" : "Add",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}