import '../../domain/entities/sale_item.dart';

class SaleItemModel extends SaleItem {
  const SaleItemModel({
    required super.productId,
    required super.productName,
    required super.price,
    required super.quantity,
  });

  factory SaleItemModel.fromMap(Map<String, dynamic> map) {
    return SaleItemModel(
      productId: map['product_id'],
      productName: map['product_name'],
      price: (map['price'] as num).toDouble(),
      quantity: map['quantity'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'product_id': productId,
      'product_name': productName,
      'price': price,
      'quantity': quantity,
    };
  }

  factory SaleItemModel.fromEntity(SaleItem item) {
    return SaleItemModel(
      productId: item.productId,
      productName: item.productName,
      price: item.price,
      quantity: item.quantity,
    );
  }
}