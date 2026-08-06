import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';

class DashboardWelcome extends StatelessWidget {
  final String userName;

  const DashboardWelcome({
    super.key,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final displayName =
        userName.trim().isEmpty
            ? l10n.storeOwner
            : userName;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            CircleAvatar(
              radius: 38,
              child: const Icon(
                Icons.person,
                size: 38,
              ),
            ),

            const SizedBox(width: 18),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${l10n.welcomeBack} 👋",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    displayName,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const Icon(
              Icons.notifications_none,
              size: 32,
            ),
          ],
        ),
      ),
    );
  }
}