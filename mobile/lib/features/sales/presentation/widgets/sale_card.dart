import 'package:flutter/material.dart';

import '../../domain/entities/sale.dart';

class SaleCard extends StatelessWidget {
  final Sale sale;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const SaleCard({
    super.key,
    required this.sale,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Icon(
                      Icons.receipt_long,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Invoice",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                        Text(
                          "#${sale.id.substring(0, 8)}",
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),

                  IconButton(
                    tooltip: "Delete",
                    icon: const Icon(
                      Icons.delete_outline,
                      color: Colors.red,
                    ),
                    onPressed: onDelete,
                  ),
                ],
              ),

              const SizedBox(height: 18),

              Row(
                children: [
                  const Icon(
                    Icons.calendar_today_outlined,
                    size: 18,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      sale.createdAt
                          .toString()
                          .substring(0, 16),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  const Icon(
                    Icons.shopping_bag_outlined,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "${sale.items.length} Items",
                  ),
                ],
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  const Icon(
                    Icons.payments_outlined,
                    color: Colors.green,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "${sale.total.toStringAsFixed(2)} DA",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: onTap,
                  icon: const Icon(Icons.visibility),
                  label: const Text(
                    "View Details",
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