import '../entities/sale.dart';
import '../repositories/sale_repository.dart';

class GetSalesUseCase {
  final SaleRepository repository;

  GetSalesUseCase(this.repository);

  Future<List<Sale>> call() {
    return repository.getSales();
  }
}