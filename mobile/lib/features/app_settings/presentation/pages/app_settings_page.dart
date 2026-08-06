import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_settings_provider.dart';

import '../widgets/language_selector.dart';
import '../widgets/theme_selector.dart';
import '../widgets/backup_tile.dart';
import '../widgets/about_tile.dart';

class AppSettingsPage extends StatelessWidget {
  const AppSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppSettingsProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Application Settings"),
            centerTitle: true,
          ),
          body: provider.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView(
                  padding: const EdgeInsets.all(16),
                  children: const [
                    LanguageSelector(),

                    SizedBox(height: 16),

                    ThemeSelector(),

                    SizedBox(height: 16),

                    BackupTile(),

                    SizedBox(height: 16),

                    AboutTile(),
                  ],
                ),
        );
      },
    );
  }
}