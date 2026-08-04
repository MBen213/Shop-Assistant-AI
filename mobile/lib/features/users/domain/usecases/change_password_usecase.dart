import '../repositories/user_repository.dart';

class ChangePasswordUseCase {
  final UserRepository repository;

  ChangePasswordUseCase(this.repository);

  Future<void> call({
    required String userId,
    required String newPassword,
  }) {
    return repository.changePassword(
      userId: userId,
      newPassword: newPassword,
    );
  }
}