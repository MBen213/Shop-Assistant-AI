import '../../../products/data/models/product_model.dart';
import '../../../products/domain/entities/product.dart';

import '../../domain/entities/stock_movement.dart';
import '../../domain/repositories/inventory_repository.dart';

import '../datasource/inventory_local_datasource.dart';

class InventoryRepositoryImpl
    implements InventoryRepository {
  final InventoryLocalDataSource localDataSource;

  InventoryRepositoryImpl(this.localDataSource);

  @override
  Future<List<Product>> getLowStockProducts() {
    return localDataSource.getLowStockProducts();
  }

  @override
  Future<List<StockMovement>> getStockMovements() {
    return localDataSource.getStockMovements();
  }

  @override
  Future<void> restockProduct({
    required Product product,
    required int quantity,
  }) {
    return localDataSource.restockProduct(
      product: ProductModel.fromEntity(product),
      quantity: quantity,
    );
  }
}