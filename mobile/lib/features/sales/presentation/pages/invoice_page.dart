import 'package:flutter/material.dart';

import '../../domain/entities/sale.dart';

class InvoicePage extends StatelessWidget {
  final Sale sale;

  const InvoicePage({
    super.key,
    required this.sale,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Invoice"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [

          const Icon(
            Icons.receipt_long,
            size: 80,
            color: Colors.indigo,
          ),

          const SizedBox(height: 16),

          const Center(
            child: Text(
              "SHOP ASSISTANT AI",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 6),

          Center(
            child: Text(
              "Invoice #${sale.id.substring(0, 8)}",
            ),
          ),

          Center(
            child: Text(
              sale.createdAt.toString(),
            ),
          ),

          const SizedBox(height: 25),

          const Divider(),

          const Text(
            "Items",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),

          const SizedBox(height: 10),

          ...sale.items.map(
            (item) => Card(
              child: ListTile(
                title: Text(item.productName),
                subtitle: Text(
                  "${item.quantity} × ${item.price.toStringAsFixed(2)} DA",
                ),
                trailing: Text(
                  "${item.subtotal.toStringAsFixed(2)} DA",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          const Divider(),

          Row(
            children: [
              const Expanded(
                child: Text(
                  "TOTAL",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                "${sale.total.toStringAsFixed(2)} DA",
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ],
          ),

          const SizedBox(height: 40),

          FilledButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.picture_as_pdf),
            label: const Text("Export PDF"),
          ),

          const SizedBox(height: 12),

          OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.print),
            label: const Text("Print Invoice"),
          ),
        ],
      ),
    );
  }
}