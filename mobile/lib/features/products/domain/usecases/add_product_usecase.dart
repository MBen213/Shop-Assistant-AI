import '../entities/product.dart';
import '../repositories/product_repository.dart';

class AddProductUseCase {
  final ProductRepository repository;

  AddProductUseCase(this.repository);

  Future<void> call(Product product) {
    return repository.addProduct(product);
  }
}