import '../entities/user.dart';
import '../repositories/user_repository.dart';

class AddUserUseCase {
  final UserRepository repository;

  AddUserUseCase(this.repository);

  Future<void> call(User user) {
    return repository.addUser(user);
  }
}