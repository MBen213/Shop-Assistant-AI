import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/store_settings_provider.dart';

class StoreInfoForm extends StatelessWidget {
  const StoreInfoForm({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<StoreSettingsProvider>();
    final settings = provider.settings;

    return Column(
      children: [
        TextFormField(
          initialValue: settings.storeName,
          decoration: const InputDecoration(
            labelText: "Store Name",
            prefixIcon: Icon(Icons.store),
            border: OutlineInputBorder(),
          ),
          onChanged: provider.updateStoreName,
        ),

        const SizedBox(height: 16),

        TextFormField(
          initialValue: settings.address,
          decoration: const InputDecoration(
            labelText: "Address",
            prefixIcon: Icon(Icons.location_on),
            border: OutlineInputBorder(),
          ),
          onChanged: provider.updateAddress,
        ),

        const SizedBox(height: 16),

        TextFormField(
          initialValue: settings.phone,
          keyboardType: TextInputType.phone,
          decoration: const InputDecoration(
            labelText: "Phone",
            prefixIcon: Icon(Icons.phone),
            border: OutlineInputBorder(),
          ),
          onChanged: provider.updatePhone,
        ),

        const SizedBox(height: 16),

        TextFormField(
          initialValue: settings.email,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            labelText: "Email",
            prefixIcon: Icon(Icons.email),
            border: OutlineInputBorder(),
          ),
          onChanged: provider.updateEmail,
        ),

        const SizedBox(height: 16),

        TextFormField(
          initialValue: settings.currency,
          decoration: const InputDecoration(
            labelText: "Currency",
            prefixIcon: Icon(Icons.payments),
            border: OutlineInputBorder(),
          ),
          onChanged: provider.updateCurrency,
        ),

        const SizedBox(height: 16),

        TextFormField(
          initialValue:
              settings.taxPercentage.toString(),
          keyboardType:
              const TextInputType.numberWithOptions(
            decimal: true,
          ),
          decoration: const InputDecoration(
            labelText: "Tax %",
            prefixIcon: Icon(Icons.percent),
            border: OutlineInputBorder(),
          ),
          onChanged: (value) {
            provider.updateTax(
              double.tryParse(value) ?? 0,
            );
          },
        ),

        const SizedBox(height: 16),

        TextFormField(
          initialValue: settings.receiptFooter,
          maxLines: 3,
          decoration: const InputDecoration(
            labelText: "Receipt Footer",
            prefixIcon: Icon(Icons.receipt_long),
            border: OutlineInputBorder(),
          ),
          onChanged: provider.updateFooter,
        ),

        const SizedBox(height: 30),

        SizedBox(
          width: double.infinity,
          height: 55,
          child: FilledButton.icon(
            onPressed: () async {
              await provider.saveSettings(
                provider.settings,
              );

              if (context.mounted) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Settings saved successfully.",
                    ),
                  ),
                );
              }
            },
            icon: const Icon(Icons.save),
            label: const Text(
              "Save Settings",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}