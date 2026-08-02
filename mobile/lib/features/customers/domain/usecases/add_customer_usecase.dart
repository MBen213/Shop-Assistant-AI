import '../entities/customer.dart';
import '../repositories/customer_repository.dart';

class AddCustomerUseCase {
  final CustomerRepository repository;

  AddCustomerUseCase(this.repository);

  Future<void> call(Customer customer) {
    return repository.addCustomer(customer);
  }
}