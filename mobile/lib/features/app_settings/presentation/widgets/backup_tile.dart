import 'package:flutter/material.dart';

class BackupTile extends StatelessWidget {
  const BackupTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(
          Icons.backup,
          color: Colors.blue,
        ),
        title: const Text(
          "Backup & Restore",
        ),
        subtitle: const Text(
          "Create or restore your database",
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 18,
        ),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                "Backup feature coming soon.",
              ),
            ),
          );
        },
      ),
    );
  }
}