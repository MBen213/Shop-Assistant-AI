import 'purchase_item.dart';

class Purchase {
  final String id;
  final String supplierId;
  final String supplierName;
  final DateTime date;
  final List<PurchaseItem> items;

  const Purchase({
    required this.id,
    required this.supplierId,
    required this.supplierName,
    required this.date,
    required this.items,
  });

  double get total =>
      items.fold(0, (sum, item) => sum + item.total);

  Purchase copyWith({
    String? id,
    String? supplierId,
    String? supplierName,
    DateTime? date,
    List<PurchaseItem>? items,
  }) {
    return Purchase(
      id: id ?? this.id,
      supplierId: supplierId ?? this.supplierId,
      supplierName: supplierName ?? this.supplierName,
      date: date ?? this.date,
      items: items ?? this.items,
    );
  }
}