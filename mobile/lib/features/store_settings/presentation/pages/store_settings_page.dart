import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/store_settings_provider.dart';

import '../widgets/store_logo.dart';
import '../widgets/store_info_form.dart';

class StoreSettingsPage extends StatelessWidget {
  const StoreSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => StoreSettingsProvider(),
      child: const _StoreSettingsView(),
    );
  }
}

class _StoreSettingsView extends StatelessWidget {
  const _StoreSettingsView();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<StoreSettingsProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Store Settings"),
        centerTitle: true,
      ),
      body: provider.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    StoreLogo(
                      logoPath: provider.settings.logoPath,
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Logo picker will be added soon.",
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 30),

                    const StoreInfoForm(),
                  ],
                ),
              ),
            ),
    );
  }
}