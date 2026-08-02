import '../../../products/domain/entities/product.dart';
import '../repositories/inventory_repository.dart';

class RestockProductUseCase {
  final InventoryRepository repository;

  RestockProductUseCase(this.repository);

  Future<void> call({
    required Product product,
    required int quantity,
  }) {
    return repository.restockProduct(
      product: product,
      quantity: quantity,
    );
  }
}