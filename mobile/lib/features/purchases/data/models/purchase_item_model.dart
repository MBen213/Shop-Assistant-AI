import '../../domain/entities/purchase_item.dart';

class PurchaseItemModel extends PurchaseItem {
  const PurchaseItemModel({
    required super.productId,
    required super.productName,
    required super.quantity,
    required super.purchasePrice,
  });

  factory PurchaseItemModel.fromMap(Map<String, dynamic> map) {
    return PurchaseItemModel(
      productId: map['productId'],
      productName: map['productName'],
      quantity: map['quantity'],
      purchasePrice: (map['purchasePrice'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'productName': productName,
      'quantity': quantity,
      'purchasePrice': purchasePrice,
    };
  }
}