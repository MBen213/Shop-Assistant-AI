import 'package:flutter/material.dart';

import '../../data/datasource/auth_remote_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/usecases/login_usecase.dart';

class LoginProvider extends ChangeNotifier {
  bool isLoading = false;

  final LoginUseCase _loginUseCase = LoginUseCase(
    AuthRepositoryImpl(
      AuthRemoteDataSource(),
    ),
  );

  Future<bool> login({
  required String email,
  required String password,
  }) async {
    isLoading = true;
    notifyListeners();

    try {
      final success = await _loginUseCase(
        email: email,
        password: password,
      );

     return success;
    } catch (_) {
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}  