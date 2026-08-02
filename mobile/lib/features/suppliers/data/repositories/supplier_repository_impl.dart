import '../../domain/entities/supplier.dart';
import '../../domain/repositories/supplier_repository.dart';
import '../datasource/supplier_local_datasource.dart';
import '../models/supplier_model.dart';

class SupplierRepositoryImpl
    implements SupplierRepository {
  final SupplierLocalDataSource localDataSource;

  SupplierRepositoryImpl(
    this.localDataSource,
  );

  @override
  Future<List<Supplier>> getSuppliers() async {
    return await localDataSource.getSuppliers();
  }

  @override
  Future<void> addSupplier(
    Supplier supplier,
  ) async {
    await localDataSource.addSupplier(
      SupplierModel.fromEntity(supplier),
    );
  }

  @override
  Future<void> updateSupplier(
    Supplier supplier,
  ) async {
    await localDataSource.updateSupplier(
      SupplierModel.fromEntity(supplier),
    );
  }

  @override
  Future<void> deleteSupplier(
    String id,
  ) async {
    await localDataSource.deleteSupplier(id);
  }
}