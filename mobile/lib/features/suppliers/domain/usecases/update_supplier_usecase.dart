import '../entities/supplier.dart';
import '../repositories/supplier_repository.dart';

class UpdateSupplierUseCase {
  final SupplierRepository repository;

  UpdateSupplierUseCase(this.repository);

  Future<void> call(
    Supplier supplier,
  ) {
    return repository.updateSupplier(
      supplier,
    );
  }
}