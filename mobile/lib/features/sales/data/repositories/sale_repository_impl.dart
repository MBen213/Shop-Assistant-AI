import '../../domain/entities/sale.dart';
import '../../domain/repositories/sale_repository.dart';
import '../datasource/sale_local_datasource.dart';
import '../models/sale_model.dart';

class SaleRepositoryImpl implements SaleRepository {
  final SaleLocalDataSource localDataSource;

  SaleRepositoryImpl(this.localDataSource);

  @override
  Future<List<Sale>> getSales() async {
    return await localDataSource.getSales();
  }

  @override
  Future<void> completeSale(Sale sale) async {
    await localDataSource.completeSale(
      SaleModel.fromEntity(sale),
    );
  }

  @override
  Future<void> deleteSale(String id) async {
    await localDataSource.deleteSale(id);
  }
}