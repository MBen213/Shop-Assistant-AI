import 'package:flutter/material.dart';

import '../../../products/data/datasource/product_remote_datasource.dart';
import '../../../products/data/repositories/product_repository_impl.dart';
import '../../../products/domain/entities/product.dart';
import '../../../products/domain/usecases/get_products_usecase.dart';

import '../../domain/entities/sale_item.dart';

class SalesProvider extends ChangeNotifier {
  SalesProvider() {
    _repository = ProductRepositoryImpl(
      ProductRemoteDataSource(),
    );

    _getProductsUseCase = GetProductsUseCase(_repository);
  }

  late final ProductRepositoryImpl _repository;
  late final GetProductsUseCase _getProductsUseCase;

  final List<Product> _products = [];
  final List<SaleItem> _cart = [];

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  List<Product> get products => List.unmodifiable(_products);

  List<SaleItem> get cart => List.unmodifiable(_cart);

  double get total =>
      _cart.fold(0.0, (sum, item) => sum + item.subtotal);

  Future<void> loadProductsFromDatabase() async {
    _isLoading = true;
    notifyListeners();

    _products
      ..clear()
      ..addAll(await _getProductsUseCase());

    _isLoading = false;
    notifyListeners();
  }

  void addToCart(Product product) {
    final index = _cart.indexWhere(
      (item) => item.productId == product.id,
    );

    if (index == -1) {
      _cart.add(
        SaleItem(
          productId: product.id,
          productName: product.name,
          price: product.sellingPrice,
          quantity: 1,
        ),
      );
    } else {
      final current = _cart[index];

      _cart[index] = current.copyWith(
        quantity: current.quantity + 1,
      );
    }

    notifyListeners();
  }

  void increaseQuantity(SaleItem item) {
    final index = _cart.indexWhere(
      (e) => e.productId == item.productId,
    );

    if (index == -1) return;

    _cart[index] = item.copyWith(
      quantity: item.quantity + 1,
    );

    notifyListeners();
  }

  void decreaseQuantity(SaleItem item) {
    final index = _cart.indexWhere(
      (e) => e.productId == item.productId,
    );

    if (index == -1) return;

    if (item.quantity <= 1) {
      _cart.removeAt(index);
    } else {
      _cart[index] = item.copyWith(
        quantity: item.quantity - 1,
      );
    }

    notifyListeners();
  }

  void removeItem(SaleItem item) {
    _cart.removeWhere(
      (e) => e.productId == item.productId,
    );

    notifyListeners();
  }

  void clearCart() {
    _cart.clear();
    notifyListeners();
  }
}