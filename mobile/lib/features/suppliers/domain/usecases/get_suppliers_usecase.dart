import '../entities/supplier.dart';
import '../repositories/supplier_repository.dart';

class GetSuppliersUseCase {
  final SupplierRepository repository;

  GetSuppliersUseCase(this.repository);

  Future<List<Supplier>> call() {
    return repository.getSuppliers();
  }
}