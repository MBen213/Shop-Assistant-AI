
import '../../domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel({
    required super.id,
    required super.name,
    required super.barcode,
    required super.purchasePrice,
    required super.sellingPrice,
    required super.quantity,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] as String,
      name: map['name'] as String,
      barcode: map['barcode'] as String,
      purchasePrice: (map['purchase_price'] as num).toDouble(),
      sellingPrice: (map['selling_price'] as num).toDouble(),
      quantity: map['quantity'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'barcode': barcode,
      'purchase_price': purchasePrice,
      'selling_price': sellingPrice,
      'quantity': quantity,
    };
  }

  factory ProductModel.fromEntity(Product product) {
    return ProductModel(
      id: product.id,
      name: product.name,
      barcode: product.barcode,
      purchasePrice: product.purchasePrice,
      sellingPrice: product.sellingPrice,
      quantity: product.quantity,
    );
  }
}