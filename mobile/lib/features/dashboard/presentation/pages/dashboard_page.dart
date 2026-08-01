import 'package:flutter/material.dart';

import '../../../products/presentation/pages/products_page.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shop Assistant AI"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          children: [
            _DashboardButton(
              icon: Icons.inventory_2,
              title: "Products",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ProductsPage(),
                  ),
                );
              },
            ),

            _DashboardButton(
              icon: Icons.shopping_cart,
              title: "Sales",
              onTap: () {},
            ),

            _DashboardButton(
              icon: Icons.people,
              title: "Customers",
              onTap: () {},
            ),

            _DashboardButton(
              icon: Icons.bar_chart,
              title: "Reports",
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class _DashboardButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _DashboardButton({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 55),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}