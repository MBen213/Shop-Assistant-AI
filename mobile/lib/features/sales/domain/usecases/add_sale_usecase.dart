import '../entities/sale.dart';
import '../repositories/sale_repository.dart';

class AddSaleUseCase {
  final SaleRepository repository;

  AddSaleUseCase(this.repository);

  Future<void> call(Sale sale) {
    return repository.completeSale(sale);
  }
}