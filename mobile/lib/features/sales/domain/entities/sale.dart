import 'sale_item.dart';

class Sale {
  final String id;
  final List<SaleItem> items;
  final double total;
  final DateTime createdAt;

  const Sale({
    required this.id,
    required this.items,
    required this.total,
    required this.createdAt,
  });

  Sale copyWith({
    String? id,
    List<SaleItem>? items,
    double? total,
    DateTime? createdAt,
  }) {
    return Sale(
      id: id ?? this.id,
      items: items ?? this.items,
      total: total ?? this.total,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}