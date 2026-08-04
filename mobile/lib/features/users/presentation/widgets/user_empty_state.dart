import 'package:flutter/material.dart';

class UserEmptyState extends StatelessWidget {
  const UserEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'No users found',
        style: TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }
}