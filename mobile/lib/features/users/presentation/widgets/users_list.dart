import 'package:flutter/material.dart';

import '../../domain/entities/user.dart';
import 'user_card.dart';

class UsersList extends StatelessWidget {
  final List<User> users;
  final ValueChanged<User> onEdit;
  final ValueChanged<User> onDelete;

  const UsersList({
    super.key,
    required this.users,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];

        return UserCard(
          user: user,
          onEdit: () => onEdit(user),
          onDelete: () => onDelete(user),
        );
      },
    );
  }
}