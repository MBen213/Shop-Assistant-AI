import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_settings_provider.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({
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
              Icons.language,
              size: 30,
            ),

            const SizedBox(width: 16),

            const Expanded(
              child: Text(
                "Language",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            DropdownButton<String>(
              value: provider.language,
              underline: const SizedBox(),
              items: const [
                DropdownMenuItem(
                  value: "en",
                  child: Text("English"),
                ),
                DropdownMenuItem(
                  value: "fr",
                  child: Text("Français"),
                ),
                DropdownMenuItem(
                  value: "ar",
                  child: Text("العربية"),
                ),
              ],
              onChanged: (value) {
                if (value == null) return;

                provider.changeLanguage(value);
              },
            ),
          ],
        ),
      ),
    );
  }
}