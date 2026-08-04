import '../../../../core/database/database_helper.dart';
import '../models/user_model.dart';

class UserLocalDataSource {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  Future<void> insertUser(UserModel user) async {
    final db = await _databaseHelper.database;

    await db.insert(
      'users',
      user.toMap(),
    );
  }

  Future<void> updateUser(UserModel user) async {
    final db = await _databaseHelper.database;

    await db.update(
      'users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  Future<void> deleteUser(String id) async {
    final db = await _databaseHelper.database;

    await db.delete(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<UserModel>> getUsers() async {
    final db = await _databaseHelper.database;

    final result = await db.query(
      'users',
      orderBy: 'full_name ASC',
    );

    return result
        .map((e) => UserModel.fromMap(e))
        .toList();
  }

  Future<UserModel?> getUserByUsername(
    String username,
  ) async {
    final db = await _databaseHelper.database;

    final result = await db.query(
      'users',
      where: 'username = ?',
      whereArgs: [username],
      limit: 1,
    );

    if (result.isEmpty) {
      return null;
    }

    return UserModel.fromMap(result.first);
  }

  Future<UserModel?> login({
    required String username,
    required String password,
  }) async {
    final db = await _databaseHelper.database;

    // ==========================
    // Debug
    // ==========================

    final allUsers = await db.query('users');

    print('');
    print('========== USERS TABLE ==========');

    if (allUsers.isEmpty) {
      print('No users found in database');
    } else {
      for (final user in allUsers) {
        print(user);
      }
    }

    print('=================================');
    print('Trying login with:');
    print('Username: $username');
    print('Password: $password');

    // ==========================

    final result = await db.query(
      'users',
      where: 'username = ? AND password_hash = ? AND is_active = 1',
      whereArgs: [
        username,
        password,
      ],
      limit: 1,
    );

    if (result.isEmpty) {
      print('❌ LOGIN FAILED');
      return null;
    }

    print('✅ LOGIN SUCCESS');

    return UserModel.fromMap(result.first);
  }

  Future<void> changePassword({
    required String userId,
    required String newPassword,
  }) async {
    final db = await _databaseHelper.database;

    await db.update(
      'users',
      {
        'password_hash': newPassword,
      },
      where: 'id = ?',
      whereArgs: [userId],
    );
  }

  Future<void> logout() async {
  }
}