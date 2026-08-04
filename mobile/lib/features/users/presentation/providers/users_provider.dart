import 'package:flutter/material.dart';

import '../../domain/entities/user.dart';
import '../../domain/usecases/add_user_usecase.dart';
import '../../domain/usecases/change_password_usecase.dart';
import '../../domain/usecases/delete_user_usecase.dart';
import '../../domain/usecases/get_users_usecase.dart';
import '../../domain/usecases/update_user_usecase.dart';

class UsersProvider extends ChangeNotifier {
  UsersProvider({
    required this.getUsersUseCase,
    required this.addUserUseCase,
    required this.updateUserUseCase,
    required this.deleteUserUseCase,
    required this.changePasswordUseCase,
  });

  final GetUsersUseCase getUsersUseCase;
  final AddUserUseCase addUserUseCase;
  final UpdateUserUseCase updateUserUseCase;
  final DeleteUserUseCase deleteUserUseCase;
  final ChangePasswordUseCase changePasswordUseCase;

  List<User> _users = [];
  List<User> _filteredUsers = [];

  bool _loading = false;

  bool get loading => _loading;

  List<User> get users => _users;

  List<User> get filteredUsers => _filteredUsers;

  Future<void> loadUsers() async {
    _loading = true;
    notifyListeners();

    _users = await getUsersUseCase();

    _filteredUsers = List.from(_users);

    _loading = false;
    notifyListeners();
  }

  void search(String text) {
    if (text.trim().isEmpty) {
      _filteredUsers = List.from(_users);
    } else {
      final keyword = text.toLowerCase();

      _filteredUsers = _users.where((user) {
        return user.fullName.toLowerCase().contains(keyword) ||
            user.username.toLowerCase().contains(keyword);
      }).toList();
    }

    notifyListeners();
  }

  Future<void> addUser(User user) async {
    await addUserUseCase(user);
    await loadUsers();
  }

  Future<void> updateUser(User user) async {
    await updateUserUseCase(user);
    await loadUsers();
  }

  Future<void> deleteUser(String id) async {
    await deleteUserUseCase(id);
    await loadUsers();
  }

  Future<void> changePassword({
    required String userId,
    required String newPassword,
  }) async {
    await changePasswordUseCase(
      userId: userId,
      newPassword: newPassword,
    );

    await loadUsers();
  }
}