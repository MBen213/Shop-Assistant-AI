import 'package:flutter/material.dart';

import '../../../products/domain/entities/product.dart';

import '../../data/datasource/inventory_local_datasource.dart';
import '../../data/repositories/inventory_repository_impl.dart';

import '../../domain/usecases/get_low_stock_products_usecase.dart';
import '../../domain/usecases/restock_product_usecase.dart';

class InventoryProvider extends ChangeNotifier {
  InventoryProvider() {
    _repository = InventoryRepositoryImpl(
      InventoryLocalDataSource(),
    );

    _getLowStockProductsUseCase =
        GetLowStockProductsUseCase(_repository);

    _restockProductUseCase =
        RestockProductUseCase(_repository);
  }

  late final InventoryRepositoryImpl _repository;

  late final GetLowStockProductsUseCase
      _getLowStockProductsUseCase;

  late final RestockProductUseCase
      _restockProductUseCase;

  final List<Product> _products = [];

  bool _loading = false;

  bool get loading => _loading;

  List<Product> get products =>
      List.unmodifiable(_products);

  Future<void> loadProducts() async {
    _loading = true;
    notifyListeners();

    _products
      ..clear()
      ..addAll(
        await _getLowStockProductsUseCase(),
      );

    _loading = false;
    notifyListeners();
  }

  Future<void> restock(
    Product product,
    int quantity,
  ) async {
    await _restockProductUseCase(
      product: product,
      quantity: quantity,
    );

    await loadProducts();
  }
}