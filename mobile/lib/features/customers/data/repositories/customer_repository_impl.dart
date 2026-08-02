import '../../domain/entities/customer.dart';
import '../../domain/repositories/customer_repository.dart';
import '../datasource/customer_local_datasource.dart';
import '../models/customer_model.dart';

class CustomerRepositoryImpl implements CustomerRepository {
  final CustomerLocalDataSource localDataSource;

  CustomerRepositoryImpl(this.localDataSource);

  @override
  Future<List<Customer>> getCustomers() async {
    return await localDataSource.getCustomers();
  }

  @override
  Future<void> addCustomer(Customer customer) async {
    await localDataSource.addCustomer(
      CustomerModel.fromEntity(customer),
    );
  }

  @override
  Future<void> updateCustomer(Customer customer) async {
    await localDataSource.updateCustomer(
      CustomerModel.fromEntity(customer),
    );
  }

  @override
  Future<void> deleteCustomer(String id) async {
    await localDataSource.deleteCustomer(id);
  }
}