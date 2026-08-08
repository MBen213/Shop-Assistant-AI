import '../../domain/entities/purchase.dart';
import 'purchase_item_model.dart';

class PurchaseModel extends Purchase {
  const PurchaseModel({
    required super.id,
    required super.supplierId,
    required super.supplierName,
    required super.date,
    required super.items,
  });

  factory PurchaseModel.fromMap(
    Map<String, dynamic> map,
    List<PurchaseItemModel> items,
  ) {
    return PurchaseModel(
      id: map['id'] as String,
      supplierId: map['supplier_id'] as String,
      supplierName: '',
      date: DateTime.parse(map['created_at'] as String),
      items: items,
    );
  }

  Map<String, dynamic> toMap() {
    double total = 0;

    for (final item in items) {
      total += item.quantity * item.purchasePrice;
    }

    return {
      'id': id,
      'supplier_id': supplierId,
      'total': total,
      'created_at': date.toIso8601String(),
    };
  }
}