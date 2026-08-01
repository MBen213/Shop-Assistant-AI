import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entities/product.dart';

import '../../data/datasource/product_remote_datasource.dart';
import '../../data/repositories/product_repository_impl.dart';
import '../../domain/usecases/add_product_usecase.dart';
import '../../domain/usecases/delete_product_usecase.dart';
import '../../domain/usecases/get_products_usecase.dart';
import '../../domain/usecases/update_product_usecase.dart';

class ProductsProvider extends ChangeNotifier {
  final ProductRepositoryImpl _repository =
      ProductRepositoryImpl(ProductRemoteDataSource());

  late final GetProductsUseCase _getProductsUseCase =
      GetProductsUseCase(_repository);

  late final AddProductUseCase _addProductUseCase =
      AddProductUseCase(_repository);

  late final UpdateProductUseCase _updateProductUseCase =
      UpdateProductUseCase(_repository);

  late final DeleteProductUseCase _deleteProductUseCase =
      DeleteProductUseCase(_repository);

  List<Product> products = [];
  List<Product> filteredProducts = [];

  bool isLoading = false;

  Future<void> loadProducts() async {
    isLoading = true;
    notifyListeners();

    products = await _getProductsUseCase();
    filteredProducts = List.from(products);

    isLoading = false;
    notifyListeners();
  }

  void search(String value) {
    if (value.isEmpty) {
     filteredProducts = List.from(products);
    } else {
     filteredProducts = products.where((product) {
       return product.name
              .toLowerCase()
              .contains(value.toLowerCase()) ||
          product.barcode.contains(value);
      }).toList();
    }

    notifyListeners();
  }

  Future<void> addProduct({
    required String name,
    required String barcode,
    required double purchasePrice,
    required double sellingPrice,
    required int quantity,
  }) async {
  final product = Product(
    id: const Uuid().v4(),
    name: name,
    barcode: barcode,
    purchasePrice: purchasePrice,
    sellingPrice: sellingPrice,
    quantity: quantity,
  );

  await _addProductUseCase(product);

  await loadProducts();
}

  Future<void> updateProduct(Product product) async {
    await _updateProductUseCase(product);
    await loadProducts();
  }

  Future<void> deleteProduct(String id) async {
    await _deleteProductUseCase(id);
    await loadProducts();
  }
}