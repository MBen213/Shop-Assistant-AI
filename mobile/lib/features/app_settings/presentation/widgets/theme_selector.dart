import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_settings_provider.dart';

class ThemeSelector extends StatelessWidget {
  const ThemeSelector({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final provider =
        context.watch<AppSettingsProvider>();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const Icon(
              Icons.dark_mode,
              size: 30,
            ),

            const SizedBox(width: 16),

            const Expanded(
              child: Text(
                "Theme",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            DropdownButton<String>(
              value: provider.themeMode,
              underline: const SizedBox(),
              items: const [
                DropdownMenuItem(
                  value: "system",
                  child: Text("System"),
                ),
                DropdownMenuItem(
                  value: "light",
                  child: Text("Light"),
                ),
                DropdownMenuItem(
                  value: "dark",
                  child: Text("Dark"),
                ),
              ],
              onChanged: (value) {
                if (value == null) return;

                provider.changeTheme(value);
              },
            ),
          ],
        ),
      ),
    );
  }
}