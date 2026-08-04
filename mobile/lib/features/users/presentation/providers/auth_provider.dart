import 'package:flutter/material.dart';

import '../../domain/entities/user.dart';
import '../../domain/usecases/get_current_user_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider({
    required this._loginUseCase,
    required this._logoutUseCase,
    required this._getCurrentUserUseCase,
  });

  final LoginUseCase _loginUseCase;
  final LogoutUseCase _logoutUseCase;
  final GetCurrentUserUseCase _getCurrentUserUseCase;

  User? _currentUser;
  bool _loading = false;

  bool get loading => _loading;
  User? get currentUser => _currentUser;
  bool get isLoggedIn => _currentUser != null;

  Future<void> checkSession() async {
    _currentUser = await _getCurrentUserUseCase();
    notifyListeners();
  }

  Future<bool> login({
    required String username,
    required String password,
  }) async {
    _loading = true;
    notifyListeners();

    _currentUser = await _loginUseCase(
      username: username,
      password: password,
    );

    _loading = false;
    notifyListeners();

    return _currentUser != null;
  }

  Future<void> logout() async {
    _loading = true;
    notifyListeners();

    await _logoutUseCase();

    _currentUser = null;

    _loading = false;
    notifyListeners();
  }
}