import '../../domain/entities/stock_movement.dart';

class StockMovementModel extends StockMovement {
  const StockMovementModel({
    required super.id,
    required super.productId,
    required super.productName,
    required super.quantityAdded,
    required super.createdAt,
  });

  factory StockMovementModel.fromEntity(
    StockMovement movement,
  ) {
    return StockMovementModel(
      id: movement.id,
      productId: movement.productId,
      productName: movement.productName,
      quantityAdded: movement.quantityAdded,
      createdAt: movement.createdAt,
    );
  }

  factory StockMovementModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return StockMovementModel(
      id: map['id'],
      productId: map['product_id'],
      productName: map['product_name'],
      quantityAdded: map['quantity_added'],
      createdAt: DateTime.parse(map['created_at']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'product_id': productId,
      'product_name': productName,
      'quantity_added': quantityAdded,
      'created_at': createdAt.toIso8601String(),
    };
  }
}