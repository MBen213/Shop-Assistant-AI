import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/user.dart';
import '../providers/users_provider.dart';
import '../widgets/user_form.dart';
import '../widgets/user_search_bar.dart';
import '../widgets/user_empty_state.dart';
import '../widgets/users_list.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _UsersView();
  }
}

class _UsersView extends StatelessWidget {
  const _UsersView();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UsersProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
      ),
      body: Column(
        children: [
          UserSearchBar(
            onChanged: provider.search,
          ),
          Expanded(
            child: provider.filteredUsers.isEmpty
                ? const UserEmptyState()
                : UsersList(
                    users: provider.filteredUsers,
                    onEdit: (user) {
                      _openForm(
                        context,
                        provider,
                        user,
                      );
                    },
                    onDelete: (user) async {
                      final confirm = await showDialog<bool>(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: const Text('Delete User'),
                              content: Text(
                                'Delete ${user.fullName} ?',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, false),
                                  child: const Text('Cancel'),
                                ),
                                FilledButton(
                                  onPressed: () =>
                                      Navigator.pop(context, true),
                                  child: const Text('Delete'),
                                ),
                              ],
                            ),
                          ) ??
                          false;

                      if (confirm) {
                        await provider.deleteUser(user.id);
                      }
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _openForm(
            context,
            provider,
            null,
          );
        },
      ),
    );
  }

  void _openForm(
    BuildContext context,
    UsersProvider provider,
    User? user,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return UserForm(
          user: user,
          onSave: ({
            required String username,
            required String password,
            required String fullName,
            required String role,
            required bool isActive,
          }) async {
            if (user == null) {
              final newUser = User(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                username: username,
                passwordHash: password,
                fullName: fullName,
                role: role,
                isActive: isActive,
                createdAt: DateTime.now(),
              );

              await provider.addUser(newUser);
            } else {
              final updatedUser = user.copyWith(
                username: username,
                passwordHash: password,
                fullName: fullName,
                role: role,
                isActive: isActive,
              );

              await provider.updateUser(updatedUser);
            }

            if (context.mounted) {
              Navigator.pop(context);
            }
          },
        );
      },
    );
  }
}