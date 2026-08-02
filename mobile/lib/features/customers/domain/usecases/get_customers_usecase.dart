import '../entities/customer.dart';
import '../repositories/customer_repository.dart';

class GetCustomersUseCase {
  final CustomerRepository repository;

  GetCustomersUseCase(this.repository);

  Future<List<Customer>> call() {
    return repository.getCustomers();
  }
}