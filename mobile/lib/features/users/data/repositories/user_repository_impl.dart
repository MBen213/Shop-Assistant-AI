import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';

import '../datasource/user_local_datasource.dart';
import '../models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final UserLocalDataSource localDataSource;

  UserRepositoryImpl(this.localDataSource);

  @override
  Future<User?> login({
    required String username,
    required String password,
  }) async {
    return await localDataSource.login(
      username: username,
      password: password,
    );
  }

  @override
  Future<void> logout() async {
    await localDataSource.logout();
  }

  @override
  Future<User?> getCurrentUser() async {
    return null;
  }

  @override
  Future<List<User>> getUsers() async {
    return await localDataSource.getUsers();
  }

  @override
  Future<void> addUser(User user) async {
    await localDataSource.insertUser(
      UserModel.fromEntity(user),
    );
  }

  @override
  Future<void> updateUser(User user) async {
    await localDataSource.updateUser(
      UserModel.fromEntity(user),
    );
  }

  @override
  Future<void> deleteUser(String id) async {
    await localDataSource.deleteUser(id);
  }

  @override
  Future<void> changePassword({
    required String userId,
    required String newPassword,
  }) async {
    await localDataSource.changePassword(
      userId: userId,
      newPassword: newPassword,
    );
  }
}