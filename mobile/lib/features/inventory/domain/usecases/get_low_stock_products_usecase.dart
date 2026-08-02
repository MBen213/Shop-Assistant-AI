import '../../../products/domain/entities/product.dart';
import '../repositories/inventory_repository.dart';

class GetLowStockProductsUseCase {
  final InventoryRepository repository;

  GetLowStockProductsUseCase(this.repository);

  Future<List<Product>> call() {
    return repository.getLowStockProducts();
  }
}