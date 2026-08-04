import 'package:flutter/material.dart';

class QuickActions extends StatelessWidget {
  final VoidCallback onNewSale;
  final VoidCallback onAddProduct;
  final VoidCallback onAddCustomer;
  final VoidCallback onAddSupplier;

  const QuickActions({
    super.key,
    required this.onNewSale,
    required this.onAddProduct,
    required this.onAddCustomer,
    required this.onAddSupplier,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Quick Actions",
          style: Theme.of(context).textTheme.titleLarge,
        ),

        const SizedBox(height: 16),

        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          childAspectRatio: 1.6,
          children: [
            _QuickActionCard(
              title: "New Sale",
              icon: Icons.point_of_sale,
              color: Colors.green,
              onTap: onNewSale,
            ),
            _QuickActionCard(
              title: "Add Product",
              icon: Icons.inventory_2,
              color: Colors.blue,
              onTap: onAddProduct,
            ),
            _QuickActionCard(
              title: "Add Customer",
              icon: Icons.people,
              color: Colors.orange,
              onTap: onAddCustomer,
            ),
            _QuickActionCard(
              title: "Add Supplier",
              icon: Icons.local_shipping,
              color: Colors.indigo,
              onTap: onAddSupplier,
            ),
          ],
        ),
      ],
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _QuickActionCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: color.withValues(alpha: 0.15),
                child: Icon(
                  icon,
                  color: color,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
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