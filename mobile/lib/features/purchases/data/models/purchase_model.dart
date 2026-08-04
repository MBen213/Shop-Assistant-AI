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
      id: map['id'],
      supplierId: map['supplierId'],
      supplierName: map['supplierName'],
      date: DateTime.parse(map['date']),
      items: items,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'supplierId': supplierId,
      'supplierName': supplierName,
      'date': date.toIso8601String(),
    };
  }
}