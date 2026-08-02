import '../entities/customer.dart';
import '../repositories/customer_repository.dart';

class UpdateCustomerUseCase {
  final CustomerRepository repository;

  UpdateCustomerUseCase(this.repository);

  Future<void> call(Customer customer) {
    return repository.updateCustomer(customer);
  }
}