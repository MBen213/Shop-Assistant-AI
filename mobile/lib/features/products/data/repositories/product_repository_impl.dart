import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasource/product_remote_datasource.dart';
import '../models/product_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Product>> getProducts() async {
    return await remoteDataSource.getProducts();
  }

  @override
  Future<void> addProduct(Product product) async {
    await remoteDataSource.addProduct(
      ProductModel.fromEntity(product),
    );
  }

  @override
  Future<void> updateProduct(Product product) async {
    await remoteDataSource.updateProduct(
      ProductModel.fromEntity(product),
    );
  }

  @override
  Future<void> deleteProduct(String id) async {
    await remoteDataSource.deleteProduct(id);
  }
}