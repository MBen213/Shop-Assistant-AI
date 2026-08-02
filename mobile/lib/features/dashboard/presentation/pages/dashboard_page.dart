import 'package:flutter/material.dart';

import '../../../products/presentation/pages/products_page.dart';
import '../../../sales/presentation/pages/sales_page.dart';
import '../../../customers/presentation/pages/customers_page.dart';
import '../../../suppliers/presentation/pages/suppliers_page.dart';
import '../../../inventory/presentation/pages/inventory_page.dart';
import '../../../reports/presentation/pages/reports_page.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shop Assistant AI"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          children: [
            _DashboardButton(
              icon: Icons.inventory_2,
              title: "Products",
              color: Colors.blue,
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
              color: Colors.green,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SalesPage(),
                  ),
                );
              },
            ),

            _DashboardButton(
              icon: Icons.people,
              title: "Customers",
              color: Colors.orange,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const CustomersPage(),
                  ),
                );
              },
            ),

            _DashboardButton(
              icon: Icons.local_shipping,
              title: "Suppliers",
              color: Colors.indigo,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SuppliersPage(),
                  ),
                );
              },
            ),

            _DashboardButton(
              icon: Icons.warehouse,
              title: "Inventory",
              color: Colors.deepPurple,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const InventoryPage(),
                  ),
                );
              },
            ),

            _DashboardButton(
              icon: Icons.bar_chart,
              title: "Reports",
              color: Colors.red,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ReportsPage(),
                  ),
                );
              },
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
  final Color color;
  final VoidCallback onTap;

  const _DashboardButton({
    required this.icon,
    required this.title,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 32,
              backgroundColor: color.withValues(alpha: 0.15),
              child: Icon(
                icon,
                size: 34,
                color: color,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}