import '../../domain/entities/purchase_item.dart';

class PurchaseItemModel extends PurchaseItem {
  const PurchaseItemModel({
    required super.productId,
    required super.productName,
    required super.quantity,
    required super.purchasePrice,
  });

  factory PurchaseItemModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return PurchaseItemModel(
      productId: map['product_id'] as String,
      productName: map['product_name'] as String,
      quantity: map['quantity'] as int,
      purchasePrice:
          (map['purchase_price'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toMap({
    required String purchaseId,
  }) {
    return {
      'purchase_id': purchaseId,
      'product_id': productId,
      'product_name': productName,
      'quantity': quantity,
      'purchase_price': purchasePrice,
    };
  }
}