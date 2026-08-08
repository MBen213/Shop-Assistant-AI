import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';

import '../datasource/product_local_datasource.dart';
import '../models/product_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  ProductRepositoryImpl(this.localDataSource);

  final ProductLocalDataSource localDataSource;

  @override
  Future<List<Product>> getProducts() async {
    return await localDataSource.getProducts();
  }

  @override
  Future<void> addProduct(Product product) async {
    await localDataSource.addProduct(
      ProductModel.fromEntity(product),
    );
  }

  @override
  Future<void> updateProduct(Product product) async {
    await localDataSource.updateProduct(
      ProductModel.fromEntity(product),
    );
  }

  @override
  Future<void> deleteProduct(String id) async {
    await localDataSource.deleteProduct(id);
  }
}