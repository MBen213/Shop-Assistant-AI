import '../entities/user.dart';

abstract class UserRepository {
  Future<User?> login({
    required String username,
    required String password,
  });

  Future<void> logout();

  Future<User?> getCurrentUser();

  Future<List<User>> getUsers();

  Future<void> addUser(User user);

  Future<void> updateUser(User user);

  Future<void> deleteUser(String id);

  Future<void> changePassword({
    required String userId,
    required String newPassword,
  });
}