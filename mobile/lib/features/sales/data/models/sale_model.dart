import '../../domain/entities/sale.dart';
import 'sale_item_model.dart';

class SaleModel extends Sale {
  const SaleModel({
    required super.id,
    required super.items,
    required super.total,
    required super.createdAt,
  });

  factory SaleModel.fromEntity(Sale sale) {
    return SaleModel(
      id: sale.id,
      items: sale.items
          .map((e) => SaleItemModel.fromEntity(e))
          .toList(),
      total: sale.total,
      createdAt: sale.createdAt,
    );
  }

  factory SaleModel.fromMap(
    Map<String, dynamic> map,
    List<SaleItemModel> items,
  ) {
    return SaleModel(
      id: map['id'],
      items: items,
      total: (map['total'] as num).toDouble(),
      createdAt: DateTime.parse(map['created_at']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'total': total,
      'created_at': createdAt.toIso8601String(),
    };
  }
}