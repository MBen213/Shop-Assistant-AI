import '../../../products/domain/entities/product.dart';
import '../entities/stock_movement.dart';

abstract class InventoryRepository {
  Future<List<Product>> getLowStockProducts();

  Future<List<StockMovement>> getStockMovements();

  Future<void> restockProduct({
    required Product product,
    required int quantity,
  });
}