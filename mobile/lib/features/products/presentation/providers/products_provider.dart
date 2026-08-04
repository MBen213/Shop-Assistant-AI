import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entities/product.dart';

import '../../domain/usecases/add_product_usecase.dart';
import '../../domain/usecases/delete_product_usecase.dart';
import '../../domain/usecases/get_products_usecase.dart';
import '../../domain/usecases/update_product_usecase.dart';

class ProductsProvider extends ChangeNotifier {
  ProductsProvider({
    required this.getProductsUseCase,
    required this.addProductUseCase,
    required this.updateProductUseCase,
    required this.deleteProductUseCase,
  });

  final GetProductsUseCase getProductsUseCase;
  final AddProductUseCase addProductUseCase;
  final UpdateProductUseCase updateProductUseCase;
  final DeleteProductUseCase deleteProductUseCase;

  List<Product> products = [];
  List<Product> filteredProducts = [];

  bool isLoading = false;

  Future<void> loadProducts() async {
    isLoading = true;
    notifyListeners();

    products = await getProductsUseCase();

    filteredProducts = List<Product>.from(products);

    isLoading = false;
    notifyListeners();
  }

  void search(String value) {
    if (value.trim().isEmpty) {
      filteredProducts = List<Product>.from(products);
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

    await addProductUseCase(product);

    await loadProducts();
  }

  Future<void> updateProduct(Product product) async {
    await updateProductUseCase(product);

    await loadProducts();
  }

  Future<void> deleteProduct(String id) async {
    await deleteProductUseCase(id);

    await loadProducts();
  }
}