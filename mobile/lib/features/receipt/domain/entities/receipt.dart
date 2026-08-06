import 'receipt_item.dart';

class Receipt {
  final String id;
  final DateTime createdAt;
  final List<ReceiptItem> items;
  final double total;

  const Receipt({
    required this.id,
    required this.createdAt,
    required this.items,
    required this.total,
  });

  int get itemsCount => items.length;

  double get subtotal =>
      items.fold(
        0.0,
        (sum, item) => sum + item.subtotal,
      );

  Receipt copyWith({
    String? id,
    DateTime? createdAt,
    List<ReceiptItem>? items,
    double? total,
  }) {
    return Receipt(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      items: items ?? this.items,
      total: total ?? this.total,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'createdAt': createdAt.toIso8601String(),
      'total': total,
      'items': items
          .map(
            (e) => e.toMap(),
          )
          .toList(),
    };
  }

  factory Receipt.fromMap(
    Map<String, dynamic> map,
  ) {
    return Receipt(
      id: map['id'] as String,
      createdAt: DateTime.parse(
        map['createdAt'] as String,
      ),
      total: (map['total'] as num).toDouble(),
      items: (map['items'] as List)
          .map(
            (e) => ReceiptItem.fromMap(
              e as Map<String, dynamic>,
            ),
          )
          .toList(),
    );
  }

  @override
  String toString() {
    return 'Receipt(id: $id, total: $total, items: ${items.length})';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Receipt &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            createdAt == other.createdAt &&
            total == other.total &&
            items == other.items;
  }

  @override
  int get hashCode => Object.hash(
        id,
        createdAt,
        total,
        items,
      );
}