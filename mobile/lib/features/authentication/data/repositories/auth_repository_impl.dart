import '../../domain/repositories/auth_repository.dart';
import '../datasource/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;

  AuthRepositoryImpl(this.remote);

  @override
  Future<bool> login({
    required String email,
    required String password,
  }) {
    return remote.login(
      email: email,
      password: password,
    );
  }
}