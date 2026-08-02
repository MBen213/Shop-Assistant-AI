import '../entities/supplier.dart';
import '../repositories/supplier_repository.dart';

class AddSupplierUseCase {
  final SupplierRepository repository;

  AddSupplierUseCase(this.repository);

  Future<void> call(
    Supplier supplier,
  ) {
    return repository.addSupplier(
      supplier,
    );
  }
}